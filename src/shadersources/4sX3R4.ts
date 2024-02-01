import { Config } from '../type'
import fragment from './glsl/4sX3R4.glsl?raw'
export default [
    {
        // '4sX3R4': 'Particle Tracing',
        name: '4sX3R4',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
