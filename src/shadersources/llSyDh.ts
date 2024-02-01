import { Config } from '../type'
import fragment from './glsl/llSyDh.glsl?raw'
export default [
    {
        // 'llSyDh': 'Hexagonal Maze Flow',
        name: 'llSyDh',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
