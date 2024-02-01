import { Config } from '../type'
import fragment from './glsl/MslGRn.glsl?raw'
export default [
    {
        // 'MslGRn': 'electron',
        name: 'MslGRn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
