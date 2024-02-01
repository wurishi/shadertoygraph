import { Config } from '../type'
import fragment from './glsl/MssGzn.glsl?raw'
export default [
    {
        // 'MssGzn': 'Quadric #1',
        name: 'MssGzn',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
