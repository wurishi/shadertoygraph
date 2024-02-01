import { Config } from '../type'
import fragment from './glsl/llVXRd.glsl?raw'
export default [
    {
        // 'llVXRd': 'Geodesic tiling',
        name: 'llVXRd',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
