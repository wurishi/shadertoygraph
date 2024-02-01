import { Config } from '../type'
import fragment from './glsl/lssGDN_79a8863c.glsl?raw'
export default [
    {
        // 'lssGDN': 'Antialiased stipple rounded line',
        name: 'lssGDN',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
