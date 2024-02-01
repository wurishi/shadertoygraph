import { Config } from '../type'
import fragment from './glsl/MdfGR8.glsl?raw'
export default [
    {
        // 'MdfGR8': 'Infinite Sierpinski',
        name: 'MdfGR8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
