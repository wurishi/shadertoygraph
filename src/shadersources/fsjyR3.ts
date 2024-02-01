import { Config } from '../type'

import Image from './glsl/fsjyR3.glsl?raw'
import Common from './glsl/fsjyR3_co.glsl?raw'
import A from './glsl/fsjyR3_a.glsl?raw'
import B from './glsl/fsjyR3_b.glsl?raw'
import C from './glsl/fsjyR3_c.glsl?raw'
import D from './glsl/fsjyR3_d.glsl?raw'

export default [
    {
        name: 'common',
        type: 'common',
        fragment: Common,
    },
    {
        name: 'fsjyR3',
        type: 'image',
        fragment: Image,
        channels: [
            { type: 'buffer', id: 0 },
            { type: 'buffer', id: 1 },
            { type: 'buffer', id: 2 },
            { type: 'buffer', id: 3 },
        ],
    },
    {
        name: 'buffA',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 0 },
            { type: 'Empty' },
            { type: 'Empty' },
            { type: 'buffer', id: 3 },
        ],
    },
    {
        name: 'buffB',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'buffer', id: 0 },
            { type: 'buffer', id: 1 },
        ],
    },
    {
        name: 'buffC',
        type: 'buffer',
        fragment: C,
        channels: [
            { type: 'buffer', id: 0 },
            { type: 'buffer', id: 1 },
        ],
    },
    {
        name: 'buffD',
        type: 'buffer',
        fragment: D,
        channels: [
            { type: 'buffer', id: 0 },
            { type: 'buffer', id: 1 },
            { type: 'buffer', id: 2 },
            { type: 'buffer', id: 3 },
        ],
    },
] as Config[]
