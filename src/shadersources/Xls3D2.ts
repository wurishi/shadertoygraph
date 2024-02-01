import { Config } from '../type'
import Image from './glsl/Xls3D2.glsl?raw'
import Sound from './glsl/Xls3D2_s.glsl?raw'

export default [
    {
        name: 'Image',
        type: 'image',
        fragment: Image,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
            },
        ],
    },
    {
        name: 'Sound',
        type: 'sound',
        fragment: Sound,
    },
] as Config[]
