import { Config } from '../type'
import fragment from './glsl/4sK3RD.glsl?raw'
import A from './glsl/4sK3RD_A.glsl?raw'
import B from './glsl/4sK3RD_B.glsl?raw'
import C from './glsl/4sK3RD_C.glsl?raw'
import D from './glsl/4sK3RD_D.glsl?raw'
export default [
    {
        // '4sK3RD': 'Rock-Paper-Scissor-4D',
        name: '4sK3RD',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'Empty' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
        ],
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
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'Empty' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'Empty' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [
            { type: 'Empty' },
            { type: 'Empty' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
        ],
    },
] as Config[]
