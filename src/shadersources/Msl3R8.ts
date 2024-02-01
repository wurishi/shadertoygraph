import { Config } from '../type'
import fragment from './glsl/Msl3R8.glsl?raw'
export default [
    {
        // 'Msl3R8': 'Mandel Fire',
        name: 'Msl3R8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
