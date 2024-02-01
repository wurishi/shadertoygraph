import { Config } from '../type'
import fragment from './glsl/ldl3R8.glsl?raw'
export default [
    {
        // 'ldl3R8': 'Edge filter',
        name: 'ldl3R8',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
