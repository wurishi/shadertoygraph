import { Config } from '../type'
import fragment from './glsl/MdsGzn.glsl?raw'
export default [
    {
        // 'MdsGzn': 'Nebelfeld',
        name: 'MdsGzn',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
