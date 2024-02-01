import { Config } from '../type'
import fragment from './glsl/4dSfRc.glsl?raw'
import A from './glsl/4dSfRc_A.glsl?raw'
import B from './glsl/4dSfRc_B.glsl?raw'
import C from './glsl/4dSfRc_C.glsl?raw'
import D from './glsl/4dSfRc_D.glsl?raw'
export default [
    {
        // '4dSfRc': '[SH17C] Raymarching tutorial',
        name: '4dSfRc',
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
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'keyboard' },
            { type: 'texture', src: 'Font1', filter: 'mipmap', wrap: 'repeat' },
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
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
            { type: 'texture', src: 'Font1', filter: 'mipmap', wrap: 'repeat' },
        ],
    },
] as Config[]
