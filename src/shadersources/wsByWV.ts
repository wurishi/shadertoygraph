import { Config } from '../type'
import fragment from './glsl/wsByWV.glsl?raw'
import Common from './glsl/wsByWV_common.glsl?raw'
import A from './glsl/wsByWV_A.glsl?raw'
import B from './glsl/wsByWV_B.glsl?raw'
import C from './glsl/wsByWV_C.glsl?raw'
import D from './glsl/wsByWV_D.glsl?raw'
export default [
    {
        // 'wsByWV': 'Voxel game Evolution',
        name: 'wsByWV',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'nearest', wrap: 'clamp' },
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
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
            { type: 'keyboard' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'nearest', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'nearest', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
        ],
    },
] as Config[]
