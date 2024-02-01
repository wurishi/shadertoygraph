import ShaderToy from './shaderToy';
import Stats from 'stats.js';
import { GUI, GUIController } from 'dat.gui';
import NameConfig from './name';
import { Config, ShaderPassConfig } from './type';
import Image, { getCubemaps, getCubemapsList } from './image';
import { fact, removeFolders } from './factGui';
import createMediaRecorder from './utils/mediaRecorder';
import { requestFullScreen } from './utils/index';
import PreviewConfig from './preview'
import base from './utils/proxy'

const shaders = import.meta.glob('./shadersources/*.ts');

let changeCurrent: ((key: string) => void) | null = null;

function init() {
  let shaderToy: ShaderToy;

  const stats = new Stats();
  document.body.appendChild(stats.dom);
  stats.dom.style.left = '';
  stats.dom.style.right = '300px';

  const keyToShaderKey = new Map<string, string>();

  const guiData = {
    current: '',
    preview: false,
    paused: false,
    goto: () => {
      const key = keyToShaderKey.get(guiData.current);
      if (key) {
        window.open(`https://www.shadertoy.com/view/${key.split('_')[0]}`, '_blank');
      }
    },
    gainValue: 0.0,
    showTextures: false,
    showCubeMaps: false,
    clipboard: () => {
      const key = keyToShaderKey.get(guiData.current);
      if (key) {
        navigator.clipboard.writeText(key);
      }
    },
    imgErr: false,
  };

  const keyToUrlMap = new Map<string, string>();

  const nameRecord = NameConfig as Record<string, string>;
  const shaderNameList = Object.keys(shaders).map((url) => {
    let arr = url.split('/');
    arr = arr[arr.length - 1].split('.');
    let key = arr[0].split('_')[0];

    if (nameRecord[key]) {
      key = `${nameRecord[key]} (${key})`;
    }
    keyToUrlMap.set(key, url);
    keyToShaderKey.set(key, arr[0]);
    return key;
  });

  const gui = new GUI();
  const mainFolder = gui.addFolder('主菜单');
  const folderMap = new Map<string, GUI>();

  let soundFolder: GUI | null;

  const changeConfigCallback = (renderpass: ShaderPassConfig[]) => {
    shaderToy.newEffect(renderpass);
  };

  const currentGUI = mainFolder
    .add(guiData, 'current', shaderNameList)
    .name('当前 ShaderToy')
    .onChange((key) => {
      window.localStorage.setItem('key_last', key)
      const url = keyToUrlMap.get(key);
      if (url) {
        removeFolders(gui, folderMap);
        const fn = shaders[url];
        if (soundFolder) {
          gui.removeFolder(soundFolder);
          soundFolder = null;
        }
        shaderToy.setGainValue(0);
        fn().then((m) => {
          const c = m.default as Config[];
          const { config: renderpass, musicCallback } = fact(
            gui,
            folderMap,
            c,
            changeConfigCallback,
            shaderToy
          );
          shaderToy.newEffect(renderpass, musicCallback!);
          if (
            renderpass.some(
              (r) =>
                r.type === 'sound' ||
                r.inputs.some((tmpi) => tmpi.type === 'music')
            )
          ) {
            soundFolder = gui.addFolder('音乐音量');
            soundFolder
              .add(guiData, 'gainValue', 0.0, 1.0, 0.01)
              .onChange((val) => {
                shaderToy.setGainValue(Number(val));
              });
            (guiData as any).exportWav = () => {
              shaderToy.exportToWav();
            };
            soundFolder.add(guiData, 'exportWav').name('导出音效');

            soundFolder.open();
            shaderToy.setGainValue(guiData.gainValue);
          }
        });
      }
    });
  changeCurrent = (name: string) => {
    window.localStorage.setItem('key_last', name);
    currentGUI.setValue(name);
    guiData.clipboard();
  };
  const previewGUI = mainFolder
    .add(guiData, 'preview')
    .name('预览列表')
    .onChange((show) => {
      showPreviews(show);
    });
  setTimeout(() => {
    previewGUI.setValue(true);
  }, 500);
  mainFolder.add(guiData, 'clipboard').name('复制key');
  mainFolder
    .add(guiData, 'paused')
    .name('暂停播放')
    .onChange(() => {
      shaderToy.pauseTime(true);
    });
  mainFolder
    .add(guiData, 'showTextures')
    .name('显示材质列表')
    .onChange((show: boolean) => {
      showTextures(show);
    });
  mainFolder
    .add(guiData, 'showCubeMaps')
    .name('显示CubeMap')
    .onChange((show) => {
      showCubeMaps(show);
    });
  mainFolder.add(guiData, 'goto').name('跳转到 ShaderToy');

  let mediaRecorder: MediaRecorder;
  let recordGUI: GUIController;
  (guiData as any).record = () => {
    if (mediaRecorder === undefined) {
      mediaRecorder = createMediaRecorder((isRecording) => {
        if (isRecording) {
          recordGUI.name('结束录制');
        } else {
          recordGUI.name('开始录制');
        }
      }, shaderToy.canvas)!;
    }
    if (mediaRecorder) {
      if (mediaRecorder.state === 'inactive') {
        mediaRecorder.start();
      } else {
        mediaRecorder.stop();
      }
    }
  };
  recordGUI = mainFolder.add(guiData, 'record').name('开始录制');
  (guiData as any).zoom = () => {
    if (shaderToy.canvas.style.width === '400px') {
      shaderToy.canvas.style.width = '800px';
      shaderToy.canvas.style.height = '600px';
    } else {
      shaderToy.canvas.style.width = '400px';
      shaderToy.canvas.style.height = '300px';
    }
  };

  mainFolder.add(guiData, 'zoom').name('放大缩小');
  (guiData as any).fullScreen = () => {
    requestFullScreen(shaderToy.canvas);
    shaderToy.canvas.focus();
  };
  mainFolder.add(guiData, 'fullScreen').name('全屏');

  mainFolder
    .add(guiData, 'imgErr')
    .name('仅显示没有预览图')
    .onChange((err) => {
      previewError(err);
    });

  mainFolder.open();

  const st = new ShaderToy();
  st.start(() => {
    stats.update();
  });
  shaderToy = st;
  return guiData;
}

const guiData = init();

const tools = document.querySelector('#tools')!;
function showTextures(show: boolean) {
  let list: HTMLDivElement = tools.querySelector('#textures')!;
  if (!list) {
    list = document.createElement('div');
    list.id = 'textures';
    list.style.display = 'flex';
    list.style.flexDirection = 'row';
    list.style.flexWrap = 'wrap';
    list.style.width = 'calc(100vw - 270px)';
    tools.appendChild(list);

    Image.forEach((img) => {
      const div = document.createElement('div');
      div.style.width = '80px';
      div.style.textAlign = 'center';
      div.style.overflow = 'hidden';
      div.style.padding = '0 5px';

      const imgEl = document.createElement('img');
      imgEl.src = img.url;
      imgEl.style.width = '100%';
      imgEl.style.height = '60px';
      div.appendChild(imgEl);

      imgEl.addEventListener('click', () => {
        if (div.style.width === '80px') {
          div.style.width = '800px';
          imgEl.style.height = '600px';
        } else {
          div.style.width = '80px';
          imgEl.style.height = '60px';
        }
      });

      const labelEl = document.createElement('div');
      labelEl.innerHTML = img.name;
      div.appendChild(labelEl);

      list.appendChild(div);
    });
  }
  if (show) {
    list.style.display = 'flex';
  } else {
    list.style.display = 'none';
  }
}

function showCubeMaps(show: boolean) {
  let list: HTMLDivElement = tools.querySelector('#cubemaps')!;
  if (!list) {
    list = document.createElement('div');
    list.id = 'cubemaps';
    list.style.display = 'flex';
    list.style.flexDirection = 'row';
    list.style.flexWrap = 'wrap';
    list.style.width = 'calc(100vw - 270px)';
    tools.appendChild(list);

    getCubemapsList().forEach((cubemap) => {
      const div = document.createElement('div');
      div.style.width = '80px';
      div.style.textAlign = 'center';
      div.style.overflow = 'hidden';
      div.style.padding = '0 5px';

      const imgEl = document.createElement('img');
      imgEl.src = getCubemaps(cubemap)[0];
      imgEl.style.width = '100%';
      imgEl.style.height = '60px';
      div.appendChild(imgEl);

      const labelEl = document.createElement('div');
      labelEl.innerHTML = cubemap;
      div.appendChild(labelEl);

      list.appendChild(div);
    });
  }

  if (show) {
    list.style.display = 'flex';
  } else {
    list.style.display = 'none';
  }
}

const imgError = new Set<string>();

function previewError(err:boolean) {
    let list:HTMLDivElement = document.querySelector('#previews')!
    if(list) {
        const len = list.children.length
        for(let i=0;i<len;i++) {
            const div = list.children.item(i) as HTMLDivElement
            if(div) {
                const key = div.getAttribute('data-key') ?? ''
                if(err) {
                    if(!imgError.has(key)) {
                        div.style.display = 'none'
                    }
                } else {
                    div.style.display = 'block'
                }
            }
        }
    }
}

const cfSet = new Set<string>()

;(() => {
  const nameRecord = NameConfig as Record<string, string>
  const tmp:any = {}
  Reflect.ownKeys(nameRecord).forEach(key => {
    const lowKey = key.toString().toLocaleLowerCase()
    if(tmp[lowKey]) {
      cfSet.add(lowKey)
    }
    else {
      tmp[lowKey] = true
    }
  })
  
})()

function showPreviews(show: boolean) {
  if(base) {
    return;
  }
  let list: HTMLDivElement = document.querySelector('#previews')!;
  if (!list) {
    list = document.createElement('div');
    list.id = 'previews';
    list.style.display = 'flex';
    list.style.flexDirection = 'row';
    list.style.flexWrap = 'wrap';
    list.style.maxHeight = '300px';
    list.style.overflow = 'auto';
    list.style.width = 'calc(100vw - 270px)';
    list.style.scrollBehavior = 'smooth'

    const infoEl = document.createElement('div')
    infoEl.innerHTML = `
    重复: ${cfSet.size} <br />
    ※预览图已修复: ${Reflect.ownKeys(PreviewConfig).length}
    `
    list.appendChild(infoEl)

    const nameRecord = NameConfig as Record<string, string>;
    Object.keys(shaders).forEach((url) => {
      let arr = url.split('/');
      arr = arr[arr.length - 1].split('.');
      const key = arr[0].split('_')[0];
      let key1 = key;
      if (nameRecord[key]) {
        key1 = `${nameRecord[key]} (${key})`;
      }
      const name = nameRecord[key];
      const item = document.createElement('div');
      item.className = 'item'
      item.style.width = '80px';
      item.style.textAlign = 'center';
      item.style.overflow = 'hidden';
      item.style.padding = '0 5px';
      item.setAttribute('data-key', key);
      setTimeout(() => {
        // 因为lazyInit是1秒后才执行的
        if (key1 === guiData.current) {
          item.style.border = '4px solid red';
        }
      }, 1500);

      const imgEl = document.createElement('img');
      imgEl.src = '/screenshot/' + arr[0] + '.jpg';
      imgEl.style.width = '100%';
      imgEl.style.height = '60px';
      item.appendChild(imgEl);
      imgEl.addEventListener('error', () => {
        const tmpSrc = '/screenshot/' + arr[0] + '.jpg'
        if(imgEl.src.endsWith(tmpSrc)) {
          imgError.add(key)
        } else {
          imgEl.src = tmpSrc
        }
      });

      const labelEl = document.createElement('div');
      labelEl.innerHTML = name || 'NONAME: ' + key;
      item.appendChild(labelEl);

      item.onclick = () => {
        item.style.border = '4px solid green';
        changeCurrent && changeCurrent(key1);
      };

      const pConfig:any = PreviewConfig
      if(key in pConfig) {
        imgEl.src = '/screenshot/' + pConfig[key] + '.jpg';
      }

      if(cfSet.has(key.toLocaleLowerCase())) {
        const warnEl = document.createElement('div')
        warnEl.className = 'cm'
        warnEl.innerHTML = '※'
        item.appendChild(warnEl)
      }

      list.appendChild(item);
    });

    document.body.appendChild(list);
  }

  if (show) {
    list.style.display = 'flex';
  } else {
    list.style.display = 'none';
  }
}

const lazyInit = () => {
  const lastKey = window.localStorage.getItem('key_last');
  const lastListStr = window.localStorage.getItem('key_list');
  let lastList: string[] = [];
  if (lastListStr) {
    lastList = JSON.parse(lastListStr);
  }

  let newKey = '';
  const tmpList: string[] = [];
  const nameRecord = NameConfig as Record<string, string>;
  const arr = Object.keys(nameRecord);
  const len = arr.length;
  for (let i = 0; i < len; i++) {
    if (nameRecord[arr[i]]) {
      const key = `${nameRecord[arr[i]]} (${arr[i]})`;
      if (lastList.indexOf(key) < 0) {
        newKey = key;
      }
      tmpList.push(key);
    }
  }
  window.localStorage.setItem('key_list', JSON.stringify(tmpList));

  // console.log('last', lastList)
  // console.log('new', arr)
  if (newKey && lastList.length > 0) {
    changeCurrent && changeCurrent(newKey);
    return;
  }

  if (lastKey) {
    changeCurrent && changeCurrent(lastKey);
  }
};

setTimeout(lazyInit, 1000);
