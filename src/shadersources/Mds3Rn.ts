import { Config } from '../type'
import fragment from './glsl/Mds3Rn.glsl?raw'
export default [
    {
        // 'Mds3Rn': 'The road to Hell',
        name: 'Mds3Rn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
