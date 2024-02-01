import { Config } from '../type'
import fragment from './glsl/lssGRH.glsl?raw'
export default [
    {
        // 'lssGRH': 'Red Planet',
        name: 'lssGRH',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
