import { Config } from '../type'
import fragment from './glsl/ll2SRy.glsl?raw'
export default [
    {
        // 'll2SRy': 'Transparent Cube Field',
        name: 'll2SRy',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
