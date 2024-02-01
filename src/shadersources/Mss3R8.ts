import { Config } from '../type'
import fragment from './glsl/Mss3R8.glsl?raw'
export default [
    {
        // 'Mss3R8': 'Julia - Distance 1',
        name: 'Mss3R8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
