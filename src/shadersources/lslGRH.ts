import { Config } from '../type'
import fragment from './glsl/lslGRH.glsl?raw'
export default [
    {
        // 'lslGRH': 'NanoTubes',
        name: 'lslGRH',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
