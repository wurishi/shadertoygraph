import { Config } from '../type'
import fragment from './glsl/cssXRH.glsl?raw'
export default [
    {
        // 'cssXRH': 'circle with segments',
        name: 'cssXRH',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
