const puppeteer = require("puppeteer");
const path = require("path");
const fs = require("fs");
const process = require("process");

const TIMEOUT = 70000;
const DOWNLOAD_FOLDER = "e";
const LOADED = {};

async function getView(browser, key) {
  const page = await browser.newPage();
  await page.goto(`https://www.shadertoy.com/view/${key}`, {
    timeout: TIMEOUT,
  });
  const res = await page.evaluate(() => {
    const httpReq = new XMLHttpRequest();
    httpReq.addEventListener("load", (event) => {
      const jsnShader = event.target.response;
      httpReq.__jsnShader = jsnShader;
    });
    httpReq.addEventListener("error", (err) => {
      console.log("getView", err);
    });
    httpReq.open("POST", "/shadertoy", false);
    // httpReq.responseType = "json";
    httpReq.setRequestHeader(
      "Content-Type",
      "application/x-www-form-urlencoded"
    );
    var str = '{ "shaders" : ["' + gShaderID + '"] }';
    str = "s=" + encodeURIComponent(str) + "&nt=1&nl=1&np=1";
    httpReq.send(str);
    return httpReq;
  });
  await page.close();
  if (res && res.__jsnShader) {
    return res.__jsnShader;
  }
}

function saveFile(key, jsnShaderStr) {
  return new Promise((resolve) => {
    let fileName = path.join(__dirname, DOWNLOAD_FOLDER, key + ".json");
    const testName = path.join(
      __dirname,
      DOWNLOAD_FOLDER,
      (key + ".json").toLocaleLowerCase()
    );
    if (fs.existsSync(testName)) {
      fileName = path.join(
        __dirname,
        DOWNLOAD_FOLDER,
        key + ".json" + "_" + Date.now()
      );
    }
    try {
      const shaderArr = JSON.parse(jsnShaderStr);
      if (Array.isArray(shaderArr) && shaderArr.length > 0) {
        fs.writeFile(fileName, JSON.stringify(shaderArr[0]), "utf-8", (err) => {
          if (err) {
            console.log("saveFile", err);
          }
          resolve();
        });
      }
    } catch (error) {}
  });
}

let browserInst = null;
async function closeBrowserInst() {
  if (browserInst) {
    console.log('关闭当前 browser');
    await browserInst.close();
    browserInst = null;
  }
}

async function getList(n, total) {
  await closeBrowserInst();
  const browser = await puppeteer.launch({ timeout: TIMEOUT, headless: "new" });
  browserInst = browser
  const page = await browser.newPage();
  const listURL = `https://www.shadertoy.com/results?query=&sort=newest&from=${n}&num=${total}`;
  await page.goto(listURL, { timeout: TIMEOUT });

  const hrefList = await page.evaluate(() =>
    [
      ...document.querySelectorAll(".searchResult .searchResultContainer a"),
    ].map((a) => a.href)
  );
  let keys = hrefList.map((href) => {
    const arr = (href + "").split("/");
    return arr.at(-1);
  });
  keys = keys.filter((k) => {
    if (k) {
      return !LOADED[k];
    }
    return false;
  });
  console.log(n, " keys:", keys);

  const len = keys.length;
  for (let i = 0; i < len; i++) {
    const key = keys[i];
    console.log("start get", key, `(${i + 1} / ${len})`);
    const st = await getView(browser, key);
    if (st) {
      console.log("save shader", key);
      await saveFile(key, st);
      LOADED[key] = true;
    }
    console.log("end", key);
  }

  await page.close();
  await closeBrowserInst();

  console.log("finish", n);

  return len;
}

const current = 101;
const NUM = 7020; // from
const PAGE = 12;

async function batch(count = 10) {
  for (let i = 0; i < count; i++) {
    let num = NUM - i * PAGE;
    if (num < 0) {
      console.log(num, "过小");
      break;
    }
    console.log(`${num} (${i}/${count})`);
    await doGetList(num);
  }
}

async function doGetList(num, retry = 1) {
  if (retry <= 3) {
    try {
      let tmp = await getList(num, PAGE);
      if (tmp > 0) {
        await getList(num, PAGE);
      }
    } catch (error) {
      console.log(`retry ${num}`, error);
      await doGetList(num, retry + 1);
    } finally {
      await closeBrowserInst();
    }
  } else {
    await closeBrowserInst();
    process.abort();
  }
}

async function recordLoaded() {
  const folder = path.join(__dirname, DOWNLOAD_FOLDER);
  const files = fs.readdirSync(folder);
  files.forEach((f) => {
    if (f.endsWith(".json")) {
      const arr = f.split(".");
      LOADED[arr[0]] = true;
    }
  });
}

function fixFile() {
  const folder = path.join(__dirname, DOWNLOAD_FOLDER);
  const files = fs.readdirSync(folder);
  const map = {};
  files.forEach((file) => {
    if (file.includes(".json_")) {
      const arr = file.split("_");
      const testKey = arr[0].toLocaleLowerCase();
      if (!map[testKey]) {
        const oldPath = path.join(folder, file);
        const newPath = path.join(folder, arr[0]);
        fs.renameSync(oldPath, newPath);
      }
      map[testKey] = true;
    }
  });
}

(() => {
  // fixFile();
  // return;

  recordLoaded();

  batch(current);
})();
