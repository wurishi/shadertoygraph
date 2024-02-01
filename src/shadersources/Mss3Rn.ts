import { Config } from '../type'
import fragment from './glsl/Mss3Rn.glsl?raw'
export default [
    {
        // 'Mss3Rn': 'Heart2',
        name: 'Mss3Rn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
