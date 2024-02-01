import { Config } from '../type'
import Image from './glsl/Ms2SD1.glsl?raw'

export default [
    {
        name: 'Ms2SD1',
        type: 'image',
        fragment: Image,
    },
] as Config[]
