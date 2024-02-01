import { Config } from '../type'
import fragment from './glsl/ldXGRS_a3c53c9f.glsl?raw'
export default [
    {
        // 'ldXGRS': 'simple ray marching example',
        name: 'ldXGRS',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
