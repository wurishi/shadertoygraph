import { Config } from '../type'
import fragment from './glsl/Msl3Rn.glsl?raw'
export default [
    {
        // 'Msl3Rn': 'Chains and Gears',
        name: 'Msl3Rn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
