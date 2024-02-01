import { Config } from '../type'
import fragment from './glsl/MdlGzn.glsl?raw'
export default [
    {
        // 'MdlGzn': 'Torus Journey',
        name: 'MdlGzn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
