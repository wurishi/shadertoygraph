import { Config } from '../type'
import fragment from './glsl/DdXSzN.glsl?raw'
import A from './glsl/DdXSzN_A.glsl?raw'
import B from './glsl/DdXSzN_B.glsl?raw'
import Common from './glsl/DdXSzN_common.glsl?raw'
import C from './glsl/DdXSzN_C.glsl?raw'
import D from './glsl/DdXSzN_D.glsl?raw'
export default [
    {
        // 'DdXSzN': 'Quake Palette experiments 6',
        name: 'DdXSzN',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'repeat' },
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Common',
        type: 'common',
        fragment: Common,
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'repeat' },
        ],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [{ type: 'buffer', id: 2, filter: 'linear', wrap: 'repeat' }],
    },
] as Config[]
