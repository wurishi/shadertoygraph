// 防止误触发
// const pt = require('path')
// const fs = require('fs')
// const crc32 = require('crc32')

const TARGET = pt.join(__dirname, 'src', 'shadersources')
const GLSL_TARGET = pt.join(TARGET, 'glsl')
const SEARCH = pt.join(__dirname, 'e')

function createTotalObj() {
    let total = 0
    let comp = 0
    let finish = 0
    const nameArr = []
    let testFlag = false

    const testFinish = (flag = false) => {
        if (flag) {
            testFlag = true
        }
        if (testFlag && comp >= total) {
            console.log('总共生成: ' + finish, ' 跳过: ' + (comp - finish))
            console.log(nameArr.join('\n'))
        }
    }

    return {
        saveName: (str) => {
            nameArr.push(str)
        },
        index: () => {
            total++
        },
        complate: (f = false) => {
            comp++
            if (f) {
                finish++
            }
            testFinish()
        },
        testFinish,
    }
}

let total = new createTotalObj()

fs.readdir(SEARCH, (err, files) => {
    if (err) {
        console.log(err)
        return
    }
    total = createTotalObj()
    files.forEach((name) => {
        if (name.endsWith('.json')) {
            total.index()
            readJSON(pt.join(SEARCH, name))
        }
    })
    total.testFinish(true)
})

const textureMap = {
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
}

const volumeMap = {
    '4sfGRr': 'GreyNoise3D',
    XdX3Rr: 'RGBANoise3D',
}

const cubeMap = {
    XdX3zn: 'Basilica',
    '4dX3zn': 'BasilicaBlur',
    XsX3zn: 'Forest',
    XsfGzn: 'Gallery',
    '4sfGzn': 'GalleryB',
}

function readJSON(path) {
    fs.readFile(path, { encoding: 'utf-8' }, (err, data) => {
        if (err) {
            console.log(err)
            return
        }
        try {
            const json = JSON.parse(data)
            const id = json.info.id
            // const fileName = id + '_' +  id.split('').map(str => str.charCodeAt(0).toString(16)).join('_')
            const fileName = id + '_' + crc32(id)
            // total.saveName(`// '${id}': '${json.info.name}',`)
            if (!fs.existsSync(pt.join(TARGET, fileName + '.ts'))) {
                const tsFileArr = ["import { Config } from '../type'"]
                const tsObjArr = ['export default [']
                json.renderpass.forEach((pass) => {
                    const channels = []
                    if (Array.isArray(pass.inputs)) {
                        pass.inputs.forEach((inp, inpIdx) => {
                            const emptyCount = inp.channel - channels.length
                            for (let i = 0; i < emptyCount; i++) {
                                channels.push({ type: 'Empty' })
                            }
                            let obj = null
                            if (inp.type === 'buffer') {
                                obj = { type: 'buffer', id: 0 }
                            } else if (inp.type === 'cubemap') {
                                obj = {
                                    type: 'cubemap',
                                    map: cubeMap[inp.id] || '',
                                }
                            } else if (inp.type === 'texture') {
                                obj = {
                                    type: 'texture',
                                    src: textureMap[inp.id] || '',
                                }
                            } else if (inp.type === 'volume') {
                                obj = {
                                    type: 'volume',
                                    volume: volumeMap[inp.id] || '',
                                }
                            } else if (inp.type === 'webcam') {
                                obj = { type: 'webcam' }
                            }
                            if (obj) {
                                if (inp.sampler.filter) {
                                    obj.filter = inp.sampler.filter
                                }
                                if (inp.sampler.wrap) {
                                    obj.wrap = inp.sampler.wrap
                                }
                                if (inp.sampler.vflip === 'false') {
                                    obj.noFlip = true
                                }
                            }
                            if (
                                inp.type === 'musicstream' ||
                                inp.type === 'music'
                            ) {
                                obj = { type: 'music' }
                            } else if (inp.type === 'keyboard') {
                                obj = { type: 'keyboard' }
                            } else if (inp.type === 'video') {
                                obj = { type: 'video' }
                            }
                            if (obj) {
                                channels.push(obj)
                            }
                        })
                    }
                    if (pass.type === 'image') {
                        tsFileArr.push(
                            `import fragment from './glsl/${fileName}.glsl?raw'`
                        )
                        tsObjArr.push(`
                        {
                            // '${id}': '${json.info.name}',
                            name: '${id}',
                            type: 'image',
                            fragment,
                            channels: ${JSON.stringify(channels)}
                        },`)
                        total.saveName(`// '${id}': '${json.info.name}',`)
                        fs.writeFile(
                            pt.join(GLSL_TARGET, `${fileName}.glsl`),
                            pass.code,
                            { encoding: 'utf-8' },
                            (err) => {
                                err && console.log(err)
                            }
                        )
                    } else if (pass.type === 'buffer') {
                        const name = pass.name[pass.name.length - 1]
                        tsFileArr.push(
                            `import ${name} from './glsl/${fileName}_${name}.glsl?raw'`
                        )
                        tsObjArr.push(`
                        {
                            name: '${pass.name}',
                            type: 'buffer',
                            fragment: ${name},
                            channels: ${JSON.stringify(channels)}
                        },`)
                        fs.writeFile(
                            pt.join(GLSL_TARGET, `${fileName}_${name}.glsl`),
                            pass.code,
                            { encoding: 'utf-8' },
                            (err) => {
                                err && console.log(err)
                            }
                        )
                    } else if (pass.type === 'sound') {
                        tsFileArr.push(
                            `import Sound from './glsl/${fileName}_sound.glsl?raw'`
                        )
                        tsObjArr.push(`
                        {
                            name: '${pass.name}',
                            type: 'sound',
                            fragment: Sound,
                        },`)
                        fs.writeFile(
                            pt.join(GLSL_TARGET, `${fileName}_sound.glsl`),
                            pass.code,
                            { encoding: 'utf-8' },
                            (err) => {
                                err && console.log(err)
                            }
                        )
                    } else if (pass.type === 'common') {
                        tsFileArr.push(
                            `import Common from './glsl/${fileName}_common.glsl?raw'`
                        )
                        tsObjArr.push(`
                        {
                            name: '${pass.name}',
                            type: 'common',
                            fragment: Common
                        },`)
                        fs.writeFile(
                            pt.join(GLSL_TARGET, `${fileName}_common.glsl`),
                            pass.code,
                            { encoding: 'utf-8' },
                            (err) => {
                                err && console.log(err)
                            }
                        )
                    } else if (pass.type === 'cubemap') {
                        tsFileArr.push(
                            `import Cube from './glsl/${fileName}_cube.glsl?raw'`
                        )
                        tsObjArr.push(`
                        {
                            name: '${pass.name}',
                            type: 'cubemap',
                            fragment: Cube
                        },`)
                        fs.writeFile(
                            pt.join(GLSL_TARGET, `${fileName}_cube.glsl`),
                            pass.code,
                            { encoding: 'utf-8' },
                            (err) => {
                                err && console.log(err)
                            }
                        )
                    }
                })
                tsObjArr.push('] as Config[]')

                const tsFile = tsFileArr.join('\n') + '\n' + tsObjArr.join('\n')
                fs.writeFile(
                    pt.join(TARGET, fileName + '.ts'),
                    tsFile,
                    { encoding: 'utf-8' },
                    (err) => {
                        err && console.log(err)
                        console.log(
                            'create succ',
                            pt.join(TARGET, fileName + '.ts')
                        )
                        total.complate(true)
                    }
                )
            } else {
                total.complate()
            }
        } catch (error) {
            console.log(error)
            total.complate()
        }
    })
}
