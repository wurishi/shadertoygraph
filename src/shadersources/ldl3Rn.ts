import { Config } from '../type'
import fragment from './glsl/ldl3Rn.glsl?raw'
export default [
    {
        // 'ldl3Rn': 'AOBench',
        name: 'ldl3Rn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
