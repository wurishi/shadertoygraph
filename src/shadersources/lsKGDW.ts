import { Config } from '../type'
import fragment from './glsl/lsKGDW.glsl?raw'
import A from './glsl/lsKGDW_A.glsl?raw'
import B from './glsl/lsKGDW_B.glsl?raw'
import C from './glsl/lsKGDW_C.glsl?raw'
export default [
    {
        // 'lsKGDW': 'oilArt',
        name: 'lsKGDW',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'music' },
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'music' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
