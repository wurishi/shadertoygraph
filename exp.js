const fs = require('fs');
const path = require('path');
const crc32 = require('crc32');

const nameFile = path.join(__dirname, './src/name.ts');
const nameJSON = path.join(__dirname, './src/name.json');

function createNodePromise(nodeFunction, ...args) {
  return new Promise((resolve, reject) => {
    nodeFunction.apply(null, [
      ...args,
      (err, files) => {
        if (err) {
          reject(err);
        }
        resolve(files);
      },
    ]);
  });
}

const searchFolder = path.join(__dirname, 'e');
const targetFolder = path.join(__dirname, 'export');

async function main() {
  try {
    fs.statSync(targetFolder);
  } catch (error) {
    fs.mkdirSync(targetFolder);
  }
  const outputs = [];
  const namePart = {};
  const files = await createNodePromise(fs.readdir, searchFolder, 'utf-8');
  for (let i = 0, len = files.length; i < len; i++) {
    const file = files[i];
    if (!file.includes('_')) {
      const arr = file.split('.');
      const newName = arr[0] + '_' + crc32(arr[0]) + '.json';
      let exist = true;
      try {
        await createNodePromise(
          fs.access,
          path.join(targetFolder, newName),
          fs.constants.F_OK
        );
      } catch (error) {
        exist = false
      }
      if (exist) {
        continue;
      }
      await createNodePromise(
        fs.copyFile,
        path.join(searchFolder, file),
        path.join(targetFolder, newName)
      );
      const raw = await createNodePromise(
        fs.readFile,
        path.join(searchFolder, file),
        'utf-8'
      );
      const json = JSON.parse(raw);
      outputs.push(`'${arr[0]}': \`${json?.info?.name}\``);
      namePart[arr[0]] = json?.info?.name;
    }
  }
  let nameObj = {};
  // load from name.ts
  // const nameFileContent = await createNodePromise(fs.readFile, nameFile, 'utf-8');
  // const nameFileArr = nameFileContent.split('\n');
  // const testArr = ["'", '"', '`'];
  // nameFileArr.forEach(line => {
  //   const arr = line.split(':');
  //   if(arr.length >= 2) {
  //     let key = arr[0].trim();
  //     if(testArr.indexOf(key[0]) >= 0) {
  //       key = key.substr(1, key.length - 2);
  //     }
  //     arr.splice(0, 1);
  //     let value = arr.join(':').trim();
  //     value = value.substr(1, value.length - (value.at(-1) === ',' ? 3 : 2));
  //     nameObj[key] = value
  //   }
  // })
  // load from name.json

  const nameJSONContent = await createNodePromise(fs.readFile, nameJSON, 'utf-8');
  nameObj = JSON.parse(nameJSONContent);
  nameObj = {...nameObj, ...namePart};
  await createNodePromise(fs.writeFile, nameJSON ,JSON.stringify(nameObj), 'utf-8');

  if (outputs.length > 0) {
    console.log(outputs.join(',\n'));
    console.log('name.ts 已更新' + outputs.length + '条(' + files.length + ')')
  } else {
    console.log('没有找到新的配置文件(' + files.length + ')');
  }

}

main();
