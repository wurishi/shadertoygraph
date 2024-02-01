import { Config } from '../type'
import fragment from './glsl/lsfGR8.glsl?raw'
export default [
    {
        // 'lsfGR8': 'Tunnel Tattoo',
        name: 'lsfGR8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
