import { Config } from '../type'
import fragment from './glsl/XdG3Wc.glsl?raw'
import A from './glsl/XdG3Wc_A.glsl?raw'
import B from './glsl/XdG3Wc_B.glsl?raw'
import C from './glsl/XdG3Wc_C.glsl?raw'
import D from './glsl/XdG3Wc_D.glsl?raw'
export default [
    {
        // 'XdG3Wc': 'pixelScreen',
        name: 'XdG3Wc',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'music' },
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [{ type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [{ type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
