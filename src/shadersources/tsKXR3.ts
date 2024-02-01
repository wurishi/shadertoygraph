import { Config } from '../type'

import fragment from './glsl/tsKXR3.glsl?raw'
import A from './glsl/tsKXR3_a.glsl?raw'
import B from './glsl/tsKXR3_b.glsl?raw'
import C from './glsl/tsKXR3_c.glsl?raw'
import D from './glsl/tsKXR3_d.glsl?raw'
import Common from './glsl/tsKXR3_common.glsl?raw'

export default [
    {
        type: 'common',
        fragment: Common,
    },
    {
        name: 'tsKXR3',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0 },
            { type: 'buffer', id: 3 },
            { type: 'buffer', id: 1 },
            { type: 'buffer', id: 2 },
        ],
    },
    {
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 0 },
            { type: 'buffer', id: 3 },
            { type: 'buffer', id: 2 },
            { type: 'buffer', id: 1 },
        ],
    },
    {
        type: 'buffer',
        fragment: B,
        channels: [{ type: 'buffer', id: 0 }],
    },
    {
        type: 'buffer',
        fragment: C,
        channels: [{ type: 'buffer', id: 1 }],
    },
    {
        type: 'buffer',
        fragment: D,
        channels: [
            { type: 'buffer', id: 0 },
            { type: 'buffer', id: 3 },
        ],
    },
] as Config[]
