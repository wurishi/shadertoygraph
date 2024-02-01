import { Config } from '../type'

import Image from './glsl/llj3Rz.glsl?raw'
import Sound from './glsl/llj3Rz_s.glsl?raw'

export default [
    {
        name: 'llj3Rz',
        type: 'image',
        fragment: Image,
        channels: [
            { type: 'texture', src: 'Stars' },
            { type: 'texture', src: 'Organic2' },
        ],
    },
    {
        name: 'a',
        type: 'sound',
        fragment: Sound,
        channels: [{ type: 'texture', src: 'Organic2' }],
    },
] as Config[]
