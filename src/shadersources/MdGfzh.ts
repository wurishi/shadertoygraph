import { Config } from '../type'
import fragment from './glsl/MdGfzh.glsl?raw'
import Common from './glsl/MdGfzh_common.glsl?raw'
import A from './glsl/MdGfzh_A.glsl?raw'
import B from './glsl/MdGfzh_B.glsl?raw'
import C from './glsl/MdGfzh_C.glsl?raw'
import D from './glsl/MdGfzh_D.glsl?raw'
export default [
    {
        // 'MdGfzh': 'Himalayas',
        name: 'MdGfzh',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
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
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'repeat' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'repeat' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'repeat' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'repeat' },
        ],
    },
] as Config[]
