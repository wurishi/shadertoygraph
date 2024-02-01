import { Config } from '../type'
import fragment from './glsl/Msf3R8.glsl?raw'
export default [
    {
        // 'Msf3R8': 'Mandelbrot Test',
        name: 'Msf3R8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
