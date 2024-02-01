import { Config } from '../type'
import fragment from './glsl/lslGR8.glsl?raw'
export default [
    {
        // 'lslGR8': 'Grassy',
        name: 'lslGR8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
