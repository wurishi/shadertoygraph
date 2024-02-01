import { Config } from '../type'
import fragment from './glsl/ldfGR8.glsl?raw'
export default [
    {
        // 'ldfGR8': 'Test1',
        name: 'ldfGR8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
