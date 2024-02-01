import { Config } from '../type'
import fragment from './glsl/MssGRS_cac689a1.glsl?raw'
export default [
    {
        // 'MssGRS': 'Gamma & sRGB',
        name: 'MssGRS',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
