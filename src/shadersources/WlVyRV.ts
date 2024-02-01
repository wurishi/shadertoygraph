import { Config } from '../type'
import fragment from './glsl/WlVyRV.glsl?raw'
import A from './glsl/WlVyRV_A.glsl?raw'
import B from './glsl/WlVyRV_B.glsl?raw'
import C from './glsl/WlVyRV_C.glsl?raw'
import Common from './glsl/WlVyRV_common.glsl?raw'
import D from './glsl/WlVyRV_D.glsl?raw'
export default [
    {
        // 'WlVyRV': 'Dry ice 2',
        name: 'WlVyRV',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
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
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Common',
        type: 'common',
        fragment: Common,
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [{ type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
