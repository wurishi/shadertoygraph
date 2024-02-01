import { Config } from '../type'
import fragment from './glsl/ldX3D8_36c5f114.glsl?raw'
export default [
    {
        // 'ldX3D8': 'cloned: rainbow spectrum',
        name: 'ldX3D8',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
