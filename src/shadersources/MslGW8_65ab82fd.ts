import { Config } from '../type'
import fragment from './glsl/MslGW8_65ab82fd.glsl?raw'
export default [
    {
        // 'MslGW8': 'ScrollMap',
        name: 'MslGW8',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RockTiles',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
