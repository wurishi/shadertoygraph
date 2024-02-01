import { Config } from '../type'
import fragment from './glsl/4tGfDW.glsl?raw'
import Common from './glsl/4tGfDW_common.glsl?raw'
import A from './glsl/4tGfDW_A.glsl?raw'
import B from './glsl/4tGfDW_B.glsl?raw'
import C from './glsl/4tGfDW_C.glsl?raw'
import D from './glsl/4tGfDW_D.glsl?raw'
export default [
    {
        // '4tGfDW': 'Chimera's Breath',
        name: '4tGfDW',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 3, filter: 'linear', wrap: 'repeat' }],
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
        channels: [{ type: 'buffer', id: 2, filter: 'linear', wrap: 'repeat' }],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'repeat' }],
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [{ type: 'buffer', id: 1, filter: 'linear', wrap: 'repeat' }],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'repeat' },
        ],
    },
] as Config[]
