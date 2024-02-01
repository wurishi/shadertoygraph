import { Config } from '../type'

import Image from './glsl/ld3Gz2.glsl?raw'

export default [
    {
        name: 'ld3Gz2',
        type: 'image',
        fragment: Image,
        channels: [
            {
                type: 'Empty',
            },
            {
                type: 'texture',
                src: 'Pebbles',
            },
            {
                type: 'texture',
                src: 'Organic2',
            },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
            },
        ],
    },
] as Config[]
