import { Config } from '../type'
import fragment from './glsl/WtfyDj.glsl?raw'
import Common from './glsl/WtfyDj_common.glsl?raw'
import A from './glsl/WtfyDj_A.glsl?raw'
import B from './glsl/WtfyDj_B.glsl?raw'
import C from './glsl/WtfyDj_C.glsl?raw'
export default [
    {
        // 'WtfyDj': 'Paint streams',
        name: 'WtfyDj',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
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
        channels: [{ type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' }],
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
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
