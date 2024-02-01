import { Config } from '../type'
import fragment from './glsl/Mss3RN_fa3825f4.glsl?raw'
export default [
    {
        // 'Mss3RN': 'Raymarching simple',
        name: 'Mss3RN',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
