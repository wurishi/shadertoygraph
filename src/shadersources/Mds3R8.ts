import { Config } from '../type'
import fragment from './glsl/Mds3R8.glsl?raw'
export default [
    {
        // 'Mds3R8': 'Lyapunov',
        name: 'Mds3R8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
