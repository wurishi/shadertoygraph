import { Config } from '../type'
import fragment from './glsl/lssGR8.glsl?raw'
export default [
    {
        // 'lssGR8': 'Pulsing Interference',
        name: 'lssGR8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
