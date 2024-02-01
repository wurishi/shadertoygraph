import { Config } from '../type'
import fragment from './glsl/MslGzn.glsl?raw'
export default [
    {
        // 'MslGzn': 'QuasiCrystal',
        name: 'MslGzn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
