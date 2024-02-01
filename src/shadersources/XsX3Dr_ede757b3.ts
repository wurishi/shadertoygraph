import { Config } from '../type'
import fragment from './glsl/XsX3Dr_ede757b3.glsl?raw'
export default [
    {
        // 'XsX3Dr': 'Palindrome',
        name: 'XsX3Dr',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'cubemap',
                map: 'Forest',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'GrayNoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'BlueNoise',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            { type: 'music' },
        ],
    },
] as Config[]
