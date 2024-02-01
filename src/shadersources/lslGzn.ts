import { Config } from '../type'
import fragment from './glsl/lslGzn.glsl?raw'
export default [
    {
        // 'lslGzn': 'QuasicrystalRiff',
        name: 'lslGzn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
