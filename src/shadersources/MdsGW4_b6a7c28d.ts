import { Config } from '../type'
import fragment from './glsl/MdsGW4_b6a7c28d.glsl?raw'
export default [
    {
        // 'MdsGW4': 'Portal to the Funk Dimension',
        name: 'MdsGW4',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
