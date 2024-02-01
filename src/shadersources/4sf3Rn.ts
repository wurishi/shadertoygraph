import { Config } from '../type'
import Image from './glsl/4sf3Rn.glsl?raw'

export default [
    {
        name: 'main',
        type: 'image',
        fragment: Image,
        channels: [
            { type: 'texture', src: 'Organic4' },
            { type: 'texture', src: 'Organic2' },
        ],
    },
] as Config[]
