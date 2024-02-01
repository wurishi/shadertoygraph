import { Config } from '../type'
import fragment from './glsl/lssGWH_f124629b.glsl?raw'
export default [
    {
        // 'lssGWH': 'Relictemp',
        name: 'lssGWH',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
