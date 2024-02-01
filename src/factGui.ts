import { GUI } from 'dat.gui'
import {
    Config,
    EffectPassInfo,
    RefreshTextureThumbail,
    Sampler,
    ShaderPassConfig,
} from './type'
import Image, {
    getCubemapsList,
    getVolume,
    getVolumeByUrl,
    getVolumeNames,
} from './image'
import ShaderToy from './shaderToy'
import drawMusicWave from './utils/drawMusicWave'

export function removeFolders(rootGUI: GUI, folderMap: Map<string, GUI>) {
    for (const folder of folderMap.values()) {
        rootGUI.removeFolder(folder)
    }
    folderMap.clear()
}

const BUFFER_IDS = [0, 1, 2, 3]
const IMAGES = Image.map((img) => img.name)
const FILTERS = ['nearest', 'linear', 'mipmap']
const WRAPS = ['clamp', 'repeat']
const VOLUMES = getVolumeNames()

function getImageName(url: string) {
    return Image.find((img) => img.url === url)?.name
}

function getImageUrl(name: string) {
    return Image.find((img) => img.name === name)?.url
}

export function fact(
    rootGUI: GUI,
    folderMap: Map<string, GUI>,
    configs: Config[],
    callback: any,
    shaderToy: ShaderToy
) {
    const guiData: any = {}
    const c: ShaderPassConfig[] = []
    let musicCallback: RefreshTextureThumbail | null = null
    const raw = parseConfig(configs)
    raw.forEach((cfg, i) => {
        c[i] = cfg
        let folderName = cfg.name || i.toString()
        if (cfg.type === 'buffer') {
            folderName += ` (id: ${
                cfg.outputs[0] ? cfg.outputs[0].id : 'UNKNOW'
            })`
        } else if (cfg.type === 'sound') {
            folderName = 'Sound'
        }
        const folder = rootGUI.addFolder(folderName)
        folderMap.set(folderName, folder)

        const title = folder.domElement.querySelector('.dg .title')
        if (title) {
            ;(title as HTMLElement).style.color = 'green'
        }

        if (cfg.type === 'buffer') {
            const id = cfg.outputs[0] ? cfg.outputs[0].id : 0
            const key = 'export_buffer_' + id
            guiData[key] = () => {
                shaderToy.exportToExr(id)
            }
            folder.add(guiData, key).name('截图 ' + folderName)
            folder.open()
        }

        cfg.inputs.forEach((inp, j) => {
            const fName = 'Channel ' + inp.channel + ' (' + inp.type + ')'
            const path = `${i}.${fName}`
            let tmpPath = path

            const subFolder = folder.addFolder(fName)
            const inputsMap = new Map<string, EffectPassInfo>()
            const getInputs = (i: number, j: number) => {
                const key = i + '_' + j
                if (!inputsMap.has(key)) {
                    inputsMap.set(key, c[i].inputs[j])
                }
                return inputsMap.get(key)!
            }

            tmpPath = path + '_empty'
            guiData[tmpPath] = false
            subFolder
                .add(guiData, tmpPath)
                .name('禁用')
                .onChange((v) => {
                    if (v) {
                        const t = getInputs(i, j)
                        c[i].inputs[j] = { channel: t.channel } as any
                    } else {
                        c[i].inputs[j] = getInputs(i, j)
                    }
                    callback && callback(c)
                })

            let addSampler = false
            if (inp.type === 'buffer') {
                addSampler = true
                tmpPath = path + '_src'
                guiData[tmpPath] = inp.src
                subFolder
                    .add(guiData, tmpPath, BUFFER_IDS)
                    .name('Buffer ID')
                    .onChange((newBID) => {
                        getInputs(i, j).src = newBID
                        callback && callback(c)
                    })
            } else if (inp.type === 'texture') {
                addSampler = true
                tmpPath = path + '_src'
                guiData[tmpPath] = getImageName(inp.src)
                subFolder
                    .add(guiData, tmpPath, IMAGES)
                    .name('Texture')
                    .onChange((newImgName) => {
                        const url = getImageUrl(newImgName)
                        if (url) {
                            getInputs(i, j).src = url
                            callback && callback(c)
                        }
                    })
            } else if (inp.type === 'volume') {
                addSampler = true
                tmpPath = path + '_src'
                const v = getVolumeByUrl(inp.src)
                if (v) {
                    guiData[tmpPath] = v.name
                    subFolder
                        .add(guiData, tmpPath, VOLUMES)
                        .name('Texture')
                        .onChange((newVolume) => {
                            const url = getVolume(newVolume)
                            if (url) {
                                getInputs(i, j).src = url.url
                                callback && callback(c)
                            }
                        })
                }
            } else if (inp.type === 'music') {
                tmpPath = path + '_audio'
                guiData[tmpPath] = 'audio.mp3'
                subFolder
                    .add(guiData, tmpPath, ['audio.mp3', 'audio2.mp3'])
                    .name('背景音乐')
                    .onChange((u) => {
                        const arr = inp.src.split('/')
                        arr[arr.length - 1] = u
                        getInputs(i, j).src = arr.join('/')
                        callback && callback(c)
                    })
                const canvas = document.createElement('canvas')
                canvas.style.background = 'black'
                canvas.width = subFolder.domElement.offsetWidth - 4
                canvas.height = (canvas.width / 4) * 3

                subFolder.domElement.appendChild(canvas)

                subFolder.open()

                musicCallback = (wave, passID) => {
                    if (passID === inp.channel) {
                        drawMusicWave(canvas, wave)
                    }
                }
            } else if (inp.type === 'video') {
                addSampler = true
                tmpPath = path + '_video'
                guiData[tmpPath] = 'video.webm'
                subFolder
                    .add(guiData, tmpPath, ['video.webm', 'video.ogm', 'video2.webm'])
                    .name('视频')
                    .onChange((u) => {
                        const arr = inp.src.split('/')
                        arr[arr.length - 1] = u
                        getInputs(i, j).src = arr.join('/')
                        callback && callback(c)
                    })

                subFolder.open()
            } else if (inp.type === 'cubemap') {
                // 目前只能首次生效
                addSampler = true
                // tmpPath = path + '_src'
                // guiData[tmpPath] = inp.src
                // subFolder
                //     .add(guiData, tmpPath, getCubemapsList())
                //     .name('Cubemap')
                //     .onChange((newCubemap) => {
                //         getInputs(i, j).src = newCubemap
                //         callback && callback(c)
                //     })
            } else if (inp.type === 'webcam') {
                addSampler = true
                tmpPath = path + '_type'
                guiData[tmpPath] = false
                subFolder.add(guiData,tmpPath)
                .name('切换为视频').onChange(flag => {
                    if(flag) {
                        getInputs(i, j).type = 'video'
                        getInputs(i, j).src = '/textures/video.webm'
                    }
                    else {
                        getInputs(i, j).type = 'webcam'
                    }
                    callback && callback(c)
                })
            }
            if (addSampler) {
                tmpPath = path + '_filter'
                guiData[tmpPath] = inp.sampler.filter
                subFolder
                    .add(guiData, tmpPath, FILTERS)
                    .name('filter')
                    .onChange((newFilter) => {
                        getInputs(i, j).sampler.filter = newFilter
                        callback && callback(c)
                    })

                tmpPath = path + '_wrap'
                guiData[tmpPath] = inp.sampler.wrap
                subFolder
                    .add(guiData, tmpPath, WRAPS)
                    .name('wrap')
                    .onChange((newWrap) => {
                        getInputs(i, j).sampler.wrap = newWrap
                        callback && callback(c)
                    })

                // if(inp.type === 'texture') {
                tmpPath = path + '_vflip'
                guiData[tmpPath] = inp.sampler.vflip
                subFolder
                    .add(guiData, tmpPath)
                    .name('vflip')
                    .onChange((newFlip) => {
                        getInputs(i, j).sampler.vflip = newFlip
                        callback && callback(c)
                    })
                // }

                subFolder.open()
            }
        })

        if (cfg.inputs.length > 0) {
            folder.open()
        }
    })

    return {
        config: c,
        musicCallback,
    }
}

function parseConfig(configs: Config[]) {
    const shaderPassConfig: ShaderPassConfig[] = []

    let buffId = 0
    configs.forEach((c, idx) => {
        const sInputs = c.channels
            ? c.channels.map<EffectPassInfo>((ch, chIdx) => {
                  let src = ''
                  const sampler: Sampler = {
                      filter: ch.filter || 'linear',
                      wrap: ch.wrap || 'clamp',
                      vflip: ch.noFlip ? false : true,
                  }
                  if (ch.type === 'buffer') {
                      src = ch.id + ''
                  } else if (ch.type === 'texture') {
                      const img = Image.find((it) => it.name === ch.src)
                      if (img) {
                          src = img.url
                      }
                      sampler.filter = ch.filter || 'mipmap'
                      sampler.wrap = ch.wrap || 'repeat'
                  } else if (ch.type === 'volume') {
                      const volume = getVolume(ch.volume)
                      if (volume) {
                          src = volume.url
                      }
                      sampler.filter = ch.filter || 'mipmap'
                      sampler.wrap = ch.wrap || 'repeat'
                  } else if (ch.type === 'music') {
                      src = '/textures/audio.mp3'
                  } else if (ch.type === 'cubemap') {
                      src = ch.map as any
                  } else if (ch.type === 'video') {
                      src = '/textures/video.webm'
                  }
                  return {
                      channel: chIdx,
                      type: ch.type as any,
                      src: src,
                      sampler,
                  }
              })
            : []
        const sOutputs: { channel: number; id: number }[] = []
        if (c.type === 'buffer') {
            sOutputs.push({
                channel: 0,
                id: buffId++,
            })
        } else if (c.type === 'cubemap') {
            sOutputs.push({
                channel: 0,
                id: 0,
            })
        }
        shaderPassConfig.push({
            name: c.name,
            type: c.type,
            code: c.fragment,
            inputs: sInputs,
            outputs: sOutputs,
        })
    })

    return shaderPassConfig
}
