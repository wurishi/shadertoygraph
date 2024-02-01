import { Config } from '../type'
import fragment from './glsl/MdXGR8.glsl?raw'
export default [
    {
        // 'MdXGR8': 'Heart3',
        name: 'MdXGR8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
