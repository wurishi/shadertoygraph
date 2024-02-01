import { Config } from '../type'
import fragment from './glsl/XdsGzH.glsl?raw'
export default [
    {
        // 'XdsGzH': 'Basic Deform Shader',
        name: 'XdsGzH',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
