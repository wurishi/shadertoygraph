import { Config } from '../type'

import main from './glsl/4dG3R1.glsl?raw'
import buffA from './glsl/4dG3R1_a.glsl?raw'

export default [
    {
        name: 'main',
        type: 'image',
        fragment: main,
        channels: [
            {
                type: 'buffer',
                id: 0,
            },
        ],
    },
    {
        name: 'BuffA',
        type: 'buffer',
        fragment: buffA,
        channels: [{ type: 'buffer', id: 0 }],
    },
] as Config[]
