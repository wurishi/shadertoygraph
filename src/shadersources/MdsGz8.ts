import { Config } from '../type'
import fragment from './glsl/MdsGz8.glsl?raw'
export default [
    {
        // 'MdsGz8': 'Marching Cubes',
        name: 'MdsGz8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
