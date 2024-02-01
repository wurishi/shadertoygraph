import { Config } from '../type'
import fragment from './glsl/MssGzH.glsl?raw'
export default [
    {
        // 'MssGzH': 'Paintballs',
        name: 'MssGzH',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
