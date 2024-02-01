import { Config } from '../type'
import fragment from './glsl/Xllfzl.glsl?raw'
import A from './glsl/Xllfzl_A.glsl?raw'
import B from './glsl/Xllfzl_B.glsl?raw'
import Sound from './glsl/Xllfzl_sound.glsl?raw'
import Common from './glsl/Xllfzl_common.glsl?raw'
export default [
    {
        // 'Xllfzl': 'Homeward',
        name: 'Xllfzl',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
            { type: 'music' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'linear',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            {
                type: 'texture',
                src: 'Lichen',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'linear',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },

    {
        name: 'Sound',
        type: 'sound',
        fragment: Sound,
    },

    {
        name: 'Common',
        type: 'common',
        fragment: Common,
    },
] as Config[]
