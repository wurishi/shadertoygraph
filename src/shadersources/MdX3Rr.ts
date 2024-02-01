import { Config } from '../type'

import Image from './glsl/MdX3Rr.glsl?raw'
import A from './glsl/MdX3Rr_a.glsl?raw'

export default [
    {
        name: 'MdX3Rr',
        type: 'image',
        fragment: Image,
        channels: [{ type: 'buffer', id: 0 }],
    },
    {
        name: 'BuffA',
        type: 'buffer',
        fragment: A,
        channels: [
            {
                type: 'texture',
                src: 'GrayNoiseMedium',
            },
        ],
    },
] as Config[]
