import { Config } from '../type'
import fragment from './glsl/fsXXzX.glsl?raw'
import Common from './glsl/fsXXzX_common.glsl?raw'
import A from './glsl/fsXXzX_A.glsl?raw'
import B from './glsl/fsXXzX_B.glsl?raw'
export default [
    {
        // 'fsXXzX': 'English Lane',
        name: 'fsXXzX',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
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
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
        ],
    },
] as Config[]
