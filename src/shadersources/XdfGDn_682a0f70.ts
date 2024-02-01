import { Config } from '../type'
import fragment from './glsl/XdfGDn_682a0f70.glsl?raw'
export default [
    {
        // 'XdfGDn': 'Colored Circles',
        name: 'XdfGDn',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
