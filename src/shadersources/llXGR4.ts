import { Config } from '../type'
import fragment from './glsl/llXGR4.glsl?raw'
export default [
    {
        // 'llXGR4': 'Antialiasing (sort of)',
        name: 'llXGR4',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
