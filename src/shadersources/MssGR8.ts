import { Config } from '../type'
import fragment from './glsl/MssGR8.glsl?raw'
export default [
    {
        // 'MssGR8': 'Basic Edge Detection',
        name: 'MssGR8',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
