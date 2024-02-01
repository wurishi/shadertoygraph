import { Config } from '../type'
import fragment from './glsl/4tl3RM.glsl?raw'
import Sound from './glsl/4tl3RM_sound.glsl?raw'
export default [
    {
        // '4tl3RM': 'Robin ',
        name: '4tl3RM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RustyMetal',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'cubemap',
                map: 'Forest',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
            {
                type: 'cubemap',
                map: 'ForestBlur',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
        ],
    },

    {
        name: 'Sound',
        type: 'sound',
        fragment: Sound,
    },
] as Config[]
