import { Config } from '../type'
import fragment from './glsl/MdsGzH.glsl?raw'
export default [
    {
        // 'MdsGzH': 'calendar',
        name: 'MdsGzH',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
