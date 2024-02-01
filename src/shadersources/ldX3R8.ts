import { Config } from '../type'
import fragment from './glsl/ldX3R8.glsl?raw'
export default [
    {
        // 'ldX3R8': 'Fake Global Illumination',
        name: 'ldX3R8',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
