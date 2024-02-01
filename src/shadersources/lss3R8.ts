import { Config } from '../type'
import fragment from './glsl/lss3R8.glsl?raw'
export default [
    {
        // 'lss3R8': 'Cel Shading',
        name: 'lss3R8',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
