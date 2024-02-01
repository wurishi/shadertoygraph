import { Config } from '../type'
import fragment from './glsl/Xtf3Rn.glsl?raw'
export default [
    {
        // 'Xtf3Rn': 'Generators',
        name: 'Xtf3Rn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
