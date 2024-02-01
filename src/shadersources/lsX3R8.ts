import { Config } from '../type'
import fragment from './glsl/lsX3R8.glsl?raw'
export default [
    {
        // 'lsX3R8': 'Balls, balls, balls!',
        name: 'lsX3R8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
