import { Config } from '../type'
import fragment from './glsl/llt3R4.glsl?raw'
export default [
    {
        // 'llt3R4': 'Ray Marching: Part 1',
        name: 'llt3R4',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
