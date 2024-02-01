import { Config } from '../type'
import Image from './glsl/XslGRr.glsl?raw'

export default [
    {
        name: 'XslGRr',
        type: 'image',
        fragment: Image,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
            },
            {
                type: 'texture',
                src: 'BlueNoise',
            },
            {
                type: 'volume',
                volume: 'GreyNoise3D',
            },
        ],
    },
] as Config[]
