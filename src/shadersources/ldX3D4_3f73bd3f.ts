import { Config } from '../type'
import fragment from './glsl/ldX3D4_3f73bd3f.glsl?raw'
export default [
    {
        // 'ldX3D4': 'Simple Posterization',
        name: 'ldX3D4',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
