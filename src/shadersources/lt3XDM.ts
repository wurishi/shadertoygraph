import { Config } from '../type'
import fragment from './glsl/lt3XDM.glsl?raw'
import A from './glsl/lt3XDM_A.glsl?raw'
import B from './glsl/lt3XDM_B.glsl?raw'
import C from './glsl/lt3XDM_C.glsl?raw'
import Common from './glsl/lt3XDM_common.glsl?raw'
export default [
    {
        // 'lt3XDM': 'Tiny Planet: Earth',
        name: 'lt3XDM',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'cubemap', map: 'ForestBlur', filter: 'mipmap', wrap: 'clamp' },
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
        name: 'Common',
        type: 'common',
        fragment: Common,
    },
] as Config[]
