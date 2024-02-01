import { Config } from '../type'
import fragment from './glsl/ldlGR8.glsl?raw'
export default [
    {
        // 'ldlGR8': 'RM Cell Shading',
        name: 'ldlGR8',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
