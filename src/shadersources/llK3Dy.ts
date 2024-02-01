import { Config } from '../type'

import Image from './glsl/llK3Dy.glsl?raw'
import A from './glsl/llK3Dy_a.glsl?raw'

export default [
    {
        name: 'llK3Dy',
        type: 'image',
        fragment: Image,
        channels: [
            {
                type: 'buffer',
                id: 0,
            },
            {
                type: 'music',
            },
        ],
    },
    {
        name: 'BuffA',
        type: 'buffer',
        fragment: A,
    },
] as Config[]
