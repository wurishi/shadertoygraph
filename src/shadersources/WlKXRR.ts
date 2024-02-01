import { Config } from '../type'
import Image from './glsl/WlKXRR.glsl?raw'
import BuffA from './glsl/WlKXRR_a.glsl?raw'

export default [
    {
        name: 'WlKXRR',
        type: 'image',
        fragment: Image,
        channels: [
            {
                type: 'buffer',
                id: 0,
            },
        ],
    },
    {
        name: 'BufferA',
        type: 'buffer',
        fragment: BuffA,
    },
] as Config[]
