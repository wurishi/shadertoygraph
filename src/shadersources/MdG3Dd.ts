import { Config } from '../type'
import Image from './glsl/MdG3Dd.glsl?raw'
import BuffA from './glsl/MdG3Dd_a.glsl?raw'
import BuffB from './glsl/MdG3Dd_b.glsl?raw'

export default [
    {
        name: 'MdG3Dd',
        type: 'image',
        fragment: Image,
        channels: [{ type: 'buffer', id: 1 }],
    },
    {
        name: 'BuffA',
        type: 'buffer',
        fragment: BuffA,
        channels: [
            {
                type: 'buffer',
                id: 0,
            },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
            },
        ],
    },
    {
        name: 'BuffB',
        type: 'buffer',
        fragment: BuffB,
        channels: [
            {
                type: 'buffer',
                id: 0,
            },
            {
                type: 'buffer',
                id: 1,
            },
        ],
    },
] as Config[]
