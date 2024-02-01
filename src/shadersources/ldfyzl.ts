import { Config } from '../type'
import Image from './glsl/ldfyzl.glsl?raw'

export default [
    {
        name: 'Image',
        type: 'image',
        fragment: Image,
        channels: [{ type: 'texture', src: 'Abstract1' }],
    },
] as Config[]
