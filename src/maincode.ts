import ShaderToy from './shaderToy';
import Stats from 'stats.js';
import { GUI, GUIController } from 'dat.gui';
import { EffectPassInfo, Sampler, ShaderPassConfig } from './type';
import Names from './name.json';
import Images, { getMusic, getVolume, musicMap } from './image';
import { getAssetsUrl } from './utils/proxy';
import createMediaRecorder from './utils/mediaRecorder';
import { requestFullScreen } from './utils/index';
import parseGLSL from './parseglsl';
import liteGraphMain from './litegraph';

// configs
// const configs = import.meta.glob('../export/*.json');

// assets
// import assets from './all.json'

function init(assets: string[]) {
  const app = document.querySelector('#app')!;
  const tools = document.querySelector('#tools')!;

  const stats = new Stats();
  tools.appendChild(stats.dom);
  stats.dom.style.left = '';
  stats.dom.style.right = '300px';

  let shaderToy = new ShaderToy();
  app.appendChild(shaderToy.canvas);
  shaderToy.start(() => {
    stats.update();
  });

  const guiData: any = {
    current: '',
  };
  const gui = new GUI();
  const mainFolder = gui.addFolder('主菜单');
  const shaders: Record<string, any> = {};
  let shaderNames: Record<string, string> = {};
  // configs
  // Object.keys(configs).forEach((key) => {
  //   const arr = key.split('/');
  //   const name = arr.at(-1)!.split('.')[0];
  //   const code = name.split('_')[0];
  //   const nameStr = (Names as any)[code] || name;
  //   shaderNames[(Names as any)[code] || name] = name;
  //   shaders[name] = configs[key];
  // });
  // assets
  assets.forEach(key => {
    const name = key.split('.')[0];
    const code = key.split('_')[0];
    const nameStr = (Names as any)[code] || name;
    shaderNames[nameStr] = name;
    shaders[name] = () => {
      return new Promise(resolve => {
        fetch(getAssetsUrl('/' + key)).then(res => {
          res.json().then(raw => {
            resolve({default: raw});
          })
        })
      })
    };
  })
  let prevGUI: GUI;
  const setCurrent = (config: any) => {
    const info = createInfo(config);
    const renderpass = createShaderPassConfig(config);

    showShaderInfo(info, tools as HTMLElement);
    shaderToy.newEffect(renderpass, musicCallback);
    recordViewedShader(config);

    if (prevGUI) {
      gui.removeFolder(prevGUI)
    }
    prevGUI = gui.addFolder(`Shader(${info.id})配置`);
    createUIWithShader(setCurrent, updateCurrentConfig, config, prevGUI);
  };
  const updateCurrentConfig = (config: any) => {
    const renderpass = createShaderPassConfig(config);
    shaderToy.newEffect(renderpass, musicCallback);
  }
  let _gainControl: GUIController;
  const sortShaderNames: Record<string, string> = {};
  Object.keys(shaderNames).sort((a, b) => a.localeCompare(b)).forEach(key => {
    sortShaderNames[key] = shaderNames[key];
  });
  const current = mainFolder
    .add(guiData, 'current', sortShaderNames)
    .name('shader')
    .onChange((name) => {
      if (window.dispatchEvent) {
        const evt = new Event('CurrentShader');
        (evt as any).name = name;
        window.dispatchEvent(evt);
      }
      const fn = shaders[name];
      fn().then((module: any) => {
        setCurrent(module.default);
      });
      _gainControl && _gainControl.setValue(0);
    });

  const mainUI = createMainUI(mainFolder, shaderToy);
  _gainControl = mainUI.gainControl;

  mainFolder.open();
  lazyInit(current, shaderNames, tools as HTMLElement);
  return {
    gui,
    setCurrent,
  };
}

(() => {
  fetch(getAssetsUrl('/all.json')).then(res => {
    res.json().then(asset => {
      const { gui, setCurrent } = init(asset);
      liteGraphMain({ gui, setCurrent });
    })
  })
})()

function musicCallback(wave: Uint8Array, passID: number) { }

function createMainUI(root: GUI, st: ShaderToy) {
  let mediaRecorder: any = undefined
  let recordControl: GUIController;
  const uiData = {
    pause: false,
    gain: 0,
    record() {
      if (mediaRecorder === undefined) {
        mediaRecorder = createMediaRecorder((isRecording) => {
          if (isRecording) {
            recordControl!.name('结束录制')
          } else {
            recordControl!.name('开始录制')
          }
        }
          , st.canvas);
      }
      if (mediaRecorder) {
        if (mediaRecorder.state === 'inactive') {
          mediaRecorder.start();
        } else {
          mediaRecorder.stop();
        }
      }
    },
    fullScreen() {
      requestFullScreen(st.canvas);
      st.canvas.focus();
    }
  };

  const pauseControl = root
    .add(uiData, 'pause')
    .onFinishChange(v => {
      pauseControl.name(v ? '继续播放' : '暂停播放');
      st.pauseTime(true);
    }).name('暂停播放');

  const gainControl = root
    .add(uiData, 'gain', 0, 1, 0.1)
    .onChange((v) => {
      st.setGainValue(v);
    })
    .name('音量');

  recordControl = root.add(uiData, 'record').name('开始录制')

  root.add(uiData, 'fullScreen').name('全屏');
  return {
    gainControl,
    recordControl
  };
}

type Info = {
  id: string;
  name: string;
  description: string;
  tags: string[];
};
function createInfo(config: any): Info {
  if (config.info) {
    return config.info;
  }
  return {
    id: 'unknow',
    name: 'unknow',
    description: '',
    tags: [],
  };
}

function createShaderPassConfig(config: any): ShaderPassConfig[] {
  const shaderPassConfigs = new Array<ShaderPassConfig>();
  if (Array.isArray(config.renderpass)) {
    config.renderpass.forEach((pass: any, idx: number) => {
      if (pass.type === 'image') {
        shaderPassConfigs.push({
          name: pass.name,
          type: 'image',
          code: pass.code,
          inputs: createInputs(pass.inputs),
          outputs: createOutputs(pass.outputs),
        });
      } else if (pass.type === 'common') {
        shaderPassConfigs.push({
          name: pass.name,
          type: 'common',
          code: pass.code,
          inputs: createInputs(pass.inputs),
          outputs: createOutputs(pass.outputs),
        });
      } else if (pass.type === 'buffer') {
        shaderPassConfigs.push({
          name: pass.name,
          type: 'buffer',
          code: pass.code,
          inputs: createInputs(pass.inputs),
          outputs: createOutputs(pass.outputs),
        });
      } else if (pass.type === 'sound') {
        shaderPassConfigs.push({
          name: pass.name,
          type: 'sound',
          code: pass.code,
          inputs: createInputs(pass.inputs),
          outputs: createOutputs(pass.outputs),
        });
      } else if (pass.type === 'cubemap') {
        shaderPassConfigs.push({
          name: pass.name,
          type: 'cubemap',
          code: pass.code,
          inputs: createInputs(pass.inputs),
          outputs: createOutputs(pass.outputs),
        });
        console.log(pass);
      } else {
        console.warn('not do it');
      }
      // console.log(pass);
      // TODO: 其他配置以及output
    });
  }
  console.log(config, shaderPassConfigs);
  return shaderPassConfigs;
}

function createInputs(inputs: any): EffectPassInfo[] {
  const infos: EffectPassInfo[] = [];
  if (Array.isArray(inputs)) {
    inputs.forEach((input, idx) => {
      const channel = input.hasOwnProperty('channel') ? input.channel : idx;
      let type = input.type;
      const sampler: Sampler = {
        filter: input.sampler?.filter || 'linear',
        wrap: input.sampler?.wrap || 'clamp',
        vflip: input.sampler?.vflip === 'true',
      };
      let src = '';
      if (input.type === 'texture') {
        const img = Images.find((it) => it.name === textureMap[input.id]);
        if (img) {
          src = getAssetsUrl(img.url);
        } else {
          console.warn('未找到img', input)
        }
        sampler.filter = input.sampler?.filter || 'mipmap';
        sampler.wrap = input.sampler?.wrap || 'repeat';
      } else if (input.type === 'music') {
        const music = getMusic(input.id);
        src = getAssetsUrl(music);
      } else if (input.type === 'musicstream') {
        type = 'music';
        src = getAssetsUrl(getMusic(input.filepath));
      } else if (input.type === 'buffer') {
        src = inputAndOutputID(input.id) + '';
      } else if (input.type === 'cubemap') {
        const cubemapUrl = cubeMap[input.id]
        if (cubemapUrl) {
          src = cubemapUrl
        } else {
          console.warn('未找到cubemapimg', input)
        }
      } else if (input.type === 'keyboard') {
      } else if (input.type === 'volume') {
        const volumn = getVolume(volumeMap[input.id])
        if (volumn) {
          src = getAssetsUrl(volumn.url)
        } else {
          console.warn('未找到volumn', input)
        }
      } else if (input.type === 'mic') {
      } else if (input.type === 'webcam') {
      }
      else {
        console.warn('未处理的input', input);
      }
      infos.push({
        channel,
        type,
        src,
        sampler,
      });
    });
  }
  return infos;
}

const bufferIDName: Record<string, number> = {
  '4dXGR8': 0,
  'XsXGR8': 1,
  '4sXGR8': 2,
  'XdfGR8': 3,
}

function inputAndOutputID(key: string): number {
  if (bufferIDName.hasOwnProperty(key)) {
    return bufferIDName[key];
  }
  console.warn('未知的input/output', key);
  return 0;
}

function createOutputs(outputs: any) {
  const outputArr = new Array<{
    id: number;
    channel: number;
  }>();
  if (Array.isArray(outputs)) {
    if (outputs.length === 1) {
      const oid = outputs[0].id;
      if (oid === '4dfGRr') {
        // main image 不需要
      }
      else if (oid === 'XsfGRr') {
        // sound 不需要
      }
      else if (oid === '4dX3Rr') {
        // cubemap
        outputArr.push({
          channel: 0,
          id: 0,
        });
      }
      else {
        outputArr.push({
          channel: 0,
          id: inputAndOutputID(oid),
        });
      }
    } else if (outputs.length > 0) {
      console.warn('无法识别的 outputs:', outputs);
    }
  }

  return outputArr;
}

const KEY_当前选择 = '_current_shader_1';
const KEY_已查看列表 = '_visited_list';

function showShaderInfo(info: Info, rootDOM: HTMLElement) {
  let div: HTMLDivElement = rootDOM.querySelector('#info') as HTMLDivElement;
  if (!div) {
    div = document.createElement('div');
    div.id = 'info';
    div.style.fontSize = '12px';
    div.style.marginTop = '20px';
    rootDOM.appendChild(div);
  }
  div.innerHTML = `<a href="https://www.shadertoy.com/view/${info.id}" target="_blank">${info.id} ${info.name}</a>
  <hr />
  TAGS: ${info.tags ? info.tags.join('|') : ''}
  <hr />
  ${(info.description + '').split('\n').join('<br />')}`
}

function recordViewedShader(config: any) {
  const id = config.info.id;
  window.localStorage.setItem(KEY_当前选择, id);

  const listStr = window.localStorage.getItem(KEY_已查看列表) || '[]';
  const vSet = new Set<string>(JSON.parse(listStr));
  vSet.add(id);
  window.localStorage.setItem(KEY_已查看列表, JSON.stringify([...vSet]));
}

function createUIWithShader(setConfig: any, updateConfig: any, config: any, gui: GUI) {
  const originalConfigStr = JSON.stringify(config);
  const uiData = {
    reset() {
      setConfig(JSON.parse(originalConfigStr))
    }
  }
  gui.add(uiData, 'reset').name('恢复为初始化配置');

  if (Array.isArray(config.renderpass)) {
    config.renderpass.forEach((pass: {
      code: string;
      inputs: any[];
      name: string;
      type: string;
    }, passIndex: number) => {
      const passFolder = gui.addFolder(pass.name);
      parseGLSL(updateConfig, config, passFolder, passIndex);
      if (Array.isArray(pass.inputs) && pass.inputs.length > 0) {
        createInputsUI(updateConfig, config, passFolder, passIndex) // config.renderpass[passIndex].inputs[j]
      }
      if (pass.type === 'image') {
        passFolder.open();
      }
    })
  }
  gui.open();
}

const inputTypeList = ['texture', 'buffer', 'music', 'keyboard', 'cubemap', 'volume', 'mic', 'webcam']

function createInputsUI(updateConfig: any, config: any, root: GUI, passIndex: number) {
  // config.renderpass[passIndex].inputs[j]
  const changeConfig = (inputIndex: number, part: any) => {
    const input = config.renderpass[passIndex].inputs[inputIndex]
    Object.keys(part).forEach(key => {
      const value = part[key]
      if (value) {
        input[key] = value
      } else {
        delete input[key]
      }
    })
    updateConfig(config)
  }

  config.renderpass[passIndex].inputs.forEach((input: {
    sampler: any;
    channel: number;
    type: string;
    id: string;
  }, i: number) => {
    if (input.type === 'musicstream') {
      input.type = 'music';
    }
    if (inputTypeList.indexOf(input.type) < 0) {
      console.warn('ui未处理 input', input)
    }
    const folder = root.addFolder('channel' + input.channel);
    const uiData = {
      type: input.type,
      texture: input.id,
      buffer: input.id,
      music: input.id,
      cubemap: input.id,
      volume: input.id,
    };
    const controlList: GUIController[] = [];
    // 根据type创建一些可控ui
    const createTextureControl = () => {
      const tControl = folder.add(uiData, 'texture', reverseKeyValue(textureMap)).onChange(texture => {
        changeConfig(i, {
          id: texture
        });
      });
      return [tControl];
    };
    const createBufferControl = () => {
      const bControl = folder.add(uiData, 'buffer', reverseKeyValue(bufferIDName)).onChange(buffer => {
        changeConfig(i, {
          id: buffer
        });
      });
      return [bControl];
    }
    const createMusicControl = () => {
      const mControl = folder.add(uiData, 'music', reverseKeyValue(musicMap)).onChange(music => {
        changeConfig(i, {
          id: music
        });
      });
      return [mControl];
    };
    const createCubeControl = () => {
      const cControl = folder.add(uiData, 'cubemap', reverseKeyValue(cubeMap)).onChange(cube => {
        changeConfig(i, {
          id: cube
        });
      });
      return [cControl];
    };
    const createVolumeControl = () => {
      const vControl = folder.add(uiData, 'volume', reverseKeyValue(volumeMap)).onChange(volume => {
        changeConfig(i, {
          id: volume
        });
      });
      return [vControl]
    };

    const createControl = (type: string): GUIController[] => {
      if (type === 'texture') {
        return createTextureControl();
      } else if (type === 'buffer') {
        return createBufferControl();
      } else if (type === 'music' || type === 'musicstream') {
        return createMusicControl();
      } else if (type === 'cubemap') {
        return createCubeControl();
      } else if (type === 'volume') {
        return createVolumeControl();
      }
      return []
    }
    //
    if (input.type === 'keyboard') {
      uiData.type = (() => { }) as any;
      folder.add(uiData, 'type').name(input.type);
    }
    else {
      folder.add(uiData, 'type', inputTypeList.filter(t => t !== 'keyboard')).onChange(type => {
        let id = ''
        if (type === 'texture') {
          uiData.texture = id = 'XdX3Rn';
        } else if (type === 'buffer') {
          uiData.buffer = id = '4dXGR8';
        } else if (type === 'music') {
          uiData.music = id = '4sXGzn';
        } else if (type === 'cubemap') {
          uiData.cubemap = id = 'XdX3zn';
        } else if (type === 'volume') {
          uiData.volume = id = '4sfGRr';
        }
        if (id) {
          controlList.forEach(control => {
            control.remove();
          });
          controlList.length = 0;
          controlList.push(...createControl(type));
          changeConfig(i, {
            type, id
          });
        }
      })
    }
    controlList.push(...createControl(input.type));
  })
}

function reverseKeyValue(obj: any) {
  const newObj: any = {}
  Object.keys(obj).forEach(key => {
    const value = obj[key]
    newObj[value] = key
  })
  return newObj
}

function lazyInit(
  gui: GUIController,
  nameToValue: Record<string, string>,
  rootDOM: HTMLElement
) {
  const list = document.createElement('div');
  rootDOM.appendChild(list);
  list.style.display = 'flex';
  list.style.flexWrap = 'wrap';
  list.style.gap = '5px';

  const div = document.createElement('button');
  div.innerHTML = '全部 visited';
  list.appendChild(div);
  div.addEventListener('click', () => {
    rootDOM.removeChild(list);
    const listStr = window.localStorage.getItem(KEY_已查看列表) || '[]';
    const vSet = new Set<string>(JSON.parse(listStr));
    Object.values(nameToValue).forEach((v) => {
      const arr = v.split('_');
      vSet.add(arr[0]);
    });
    window.localStorage.setItem(KEY_已查看列表, JSON.stringify([...vSet]));
  });

  const clickHandler = (evt: Event) => {
    const t: any = evt.target!;
    const target = t as EventTarget & { id: string };
    gui.setValue(target.id);
    target.removeEventListener('click', clickHandler);
    list.removeChild(t);
  };
  setTimeout(() => {
    try {
      const id = window.localStorage.getItem(KEY_当前选择);
      if (id && !gui.getValue()) {
        const name = (Names as any)[id] || id;
        const value = nameToValue[name];
        if (value) {
          gui.setValue(value);
        } else {
          console.warn('lazyinit error: ', id);
        }
      }

      const listStr = window.localStorage.getItem(KEY_已查看列表) || '[]';
      const visitList = JSON.parse(listStr);
      const visitSet = new Set<string>();
      visitList.forEach((id: any) => {
        const name = (Names as any)[id] || id;
        visitSet.add(nameToValue[name]);
      });
      let noVisitCount = 0;
      Object.keys(nameToValue).forEach((key) => {
        const value = nameToValue[key];
        if (!visitSet.has(value)) {
          noVisitCount++;
          const div = document.createElement('button');
          div.id = value;
          div.innerHTML = key;
          list.appendChild(div);
          div.addEventListener('click', clickHandler);
        }
      });
      div.innerHTML = `全部 visited (${noVisitCount})`;
    } catch (exp) { }
  }, 1000);

  const searchList = rootDOM.querySelector('#searchList');
  const slist = rootDOM.querySelector('#slist');
  if (searchList && slist) {
    searchList.addEventListener('change', () => {
      const searchName = (searchList as any).value;
      const value = nameToValue[searchName];
      if (value) {
        gui.setValue(value);
      } else {
        console.warn('search error: ', searchName);
      }
    })

    Object.keys(nameToValue).forEach(item => {
      const opt = document.createElement('option');
      opt.value = item;
      slist.appendChild(opt);
    })
  }
}

const textureMap: any = {
  XdX3Rn: 'Abstract1',
  '4dfGRn': 'London',
  XdfGRn: 'Stars',
  XsXGRn: 'Organic1',
  '4dX3Rn': 'Abstract2',
  '4dXGRn': 'RockTiles',
  Xsf3Rn: 'Nyancat',
  XsX3Rn: 'Organic2',
  Xsf3zn: 'RGBANoiseMedium',
  XsfGRn: 'Wood',
  XsBSR3: 'BlueNoise',
  XdXGzn: 'RGBANoiseSmall',
  '4sfGRn': 'Lichen',
  '4sXGRn': 'RustyMetal',
  '4dXGzn': 'GrayNoiseMedium',
  '4sf3Rr': 'Pebbles',
  Xdf3zn: 'Bayer',
  '4sf3Rn': 'GrayNoiseSmall',
  Xsf3Rr: 'Organic3',
  XdXGzr: 'Abstract3',
  '4df3Rr': 'Organic4',
  '4dXGzr': 'Font1'
};

const volumeMap: any = {
  '4sfGRr': 'GreyNoise3D',
  XdX3Rr: 'RGBANoise3D',
};

const cubeMap: any = {
  XdX3zn: 'Basilica',
  '4dX3zn': 'BasilicaBlur',
  XsX3zn: 'Forest',
  XsfGzn: 'Gallery',
  '4sfGzn': 'GalleryB',
  '4sX3zn': 'ForestBlur'
};