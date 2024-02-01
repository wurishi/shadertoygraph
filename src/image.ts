import { Format } from './type'
import { getAssetsUrl } from './utils/proxy'

const FOLDER = '/textures/'
const CUBEMAPS_FOLDER = FOLDER + 'cubemaps/'

type ImageConfig = {
    name: string
    url: string
    channel: number
    format: Format
}

function createImageConfig(file: string, channel: number): ImageConfig {
    return {
        name: file.split('.')[0],
        url: FOLDER + file,
        channel,
        format: channel === 1 ? 'C1I8' : 'C4I8',
    }
}

const imageList = [
    createImageConfig('Abstract1.jpeg', 3),
    createImageConfig('Abstract2.jpeg', 3),
    createImageConfig('Abstract3.jpeg', 3),
    createImageConfig('Bayer.png', 1),
    createImageConfig('BlueNoise.png', 4),
    createImageConfig('Font1.png', 4),
    createImageConfig('GrayNoiseMedium.png', 1),
    createImageConfig('GrayNoiseSmall.png', 1),
    createImageConfig('Lichen.jpeg', 3),
    createImageConfig('London.jpeg', 3),
    createImageConfig('Nyancat.png', 4),
    createImageConfig('Organic1.jpeg', 3),
    createImageConfig('Organic2.jpeg', 3),
    createImageConfig('Organic3.jpeg', 3),
    createImageConfig('Organic4.jpeg', 3),
    createImageConfig('Pebbles.png', 1),
    createImageConfig('RGBANoiseMedium.png', 4),
    createImageConfig('RGBANoiseSmall.png', 4),
    createImageConfig('RockTiles.jpeg', 3),
    createImageConfig('RustyMetal.jpeg', 3),
    createImageConfig('Stars.jpeg', 3),
    createImageConfig('Wood.jpeg', 3),
]

export default imageList

export function getImageConfigByUrl(url: string) {
    return imageList.find((img) => img.url === url)
}

type Volume = {
    name: string
    url: string
}
const volumeList: Volume[] = [
    {
        name: 'GreyNoise3D',
        url: FOLDER + 'GreyNoise3D.bin',
    },
    {
        name: 'RGBANoise3D',
        url: FOLDER + 'RGBANoise3D.bin',
    },
]

export function getVolume(name: string) {
    return volumeList.find((v) => v.name === name)
}

export function getVolumeByUrl(url: string) {
    return volumeList.find((v) => v.url === url)
}

export function getVolumeNames() {
    return volumeList.map((v) => v.name)
}

const POSTFIX: Record<string, string> = {
    Basilica: '.jpeg',
    Forest: '.png',
    ForestBlur: '.png',
    BasilicaBlur: '.png',
    Gallery: '.jpeg',
    GalleryB: '.png',
}

export function getCubemapsList() {
    return Object.keys(POSTFIX)
}

export function getCubemaps(name: string) {
    const maps: string[] = []
    for (let i = 0; i < 6; i++) {
        const tmp = i === 0 ? name : name + '_' + i
        maps.push(getAssetsUrl(CUBEMAPS_FOLDER + tmp + POSTFIX[name]))
    }

    return maps
}

export const musicMap: Record<string, string> = {
    default: '8-bit-mentality.mp3',
    '4sXGzn': '8-bit-mentality.mp3',
    '4df3Rn': 'Electronebulae.mp3',
    'XsXGzn': 'Experiment.mp3',
    "4sXGRr": "Most-Geometric-Person.mp3",
    "XsXGRr": "Tropical-Beeper.mp3",
    "XdfGzn": "X-TrackTure.mp3",
    '4dfGzn': 'ourpithyator.mp3'
}

export function getMusic(key: string) {
    if(!musicMap[key]) {
        console.log('music: 使用default代替了 ' + key)
    }
    let file = musicMap[key] || musicMap.default
    return FOLDER + file
}