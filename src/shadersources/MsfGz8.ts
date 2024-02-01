import { Config } from '../type'
import fragment from './glsl/MsfGz8.glsl?raw'
export default [
    {
        // 'MsfGz8': 'Ray marching soft-shadows',
        name: 'MsfGz8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
