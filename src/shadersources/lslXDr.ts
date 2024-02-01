import { Config } from '../type'
import fragment from './glsl/lslXDr.glsl?raw'
export default [
    {
        // 'lslXDr': 'Atmospheric Scattering Sample',
        name: 'lslXDr',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
