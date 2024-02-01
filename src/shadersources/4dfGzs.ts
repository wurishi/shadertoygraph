import { Config } from '../type'
import Image from './glsl/4dfGzs.glsl?raw'

export default [
    {
        name: '4dfGzs',
        type: 'image',
        fragment: Image,
        channels: [{ type: 'texture', src: 'RGBANoiseMedium' }],
    },
] as Config[]
