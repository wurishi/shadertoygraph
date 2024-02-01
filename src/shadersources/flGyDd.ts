import { Config } from '../type'

import Image from './glsl/flGyDd.glsl?raw'
import A from './glsl/flGyDd_a.glsl?raw'
import B from './glsl/flGyDd_b.glsl?raw'

export default [
    {
        name: 'flGyDd',
        type: 'image',
        fragment: Image,
        channels: [{ type: 'buffer', id: 1 }],
    },
    {
        name: 'a',
        type: 'buffer',
        fragment: A,
    },
    {
        name: 'b',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'buffer', id: 0 },
            { type: 'buffer', id: 1 },
        ],
    },
] as Config[]
