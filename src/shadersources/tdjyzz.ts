import { Config } from '../type'
import fragment from './glsl/tdjyzz.glsl?raw'
import Common from './glsl/tdjyzz_common.glsl?raw'
import A from './glsl/tdjyzz_A.glsl?raw'
import B from './glsl/tdjyzz_B.glsl?raw'
export default [
    {
        // 'tdjyzz': 'Tree in the wind',
        name: 'tdjyzz',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'music' },
        ],
    },

    {
        name: 'Common',
        type: 'common',
        fragment: Common,
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'Empty' },
            {
                type: 'texture',
                src: 'GrayNoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'GrayNoiseMedium',
                filter: 'linear',
                wrap: 'repeat',
            },
            { type: 'volume', volume: 'GreyNoise3D' },
        ],
    },
] as Config[]
