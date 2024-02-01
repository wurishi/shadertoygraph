import { Config } from '../type'
import fragment from './glsl/MldXWX.glsl?raw'
import A from './glsl/MldXWX_A.glsl?raw'
import B from './glsl/MldXWX_B.glsl?raw'
import C from './glsl/MldXWX_C.glsl?raw'
import D from './glsl/MldXWX_D.glsl?raw'
export default [
    {
        // 'MldXWX': 'curtain and ball',
        name: 'MldXWX',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'Empty' },
            { type: 'buffer', id: 3, filter: 'nearest', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'Empty' },
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [
            { type: 'Empty' },
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [
            { type: 'Empty' },
            { type: 'buffer', id: 2, filter: 'nearest', wrap: 'clamp' },
        ],
    },
] as Config[]
