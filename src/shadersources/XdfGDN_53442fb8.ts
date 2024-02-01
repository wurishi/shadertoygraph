import { Config } from '../type'
import fragment from './glsl/XdfGDN_53442fb8.glsl?raw'
export default [
    {
        // 'XdfGDN': 'Wobbly Chrome',
        name: 'XdfGDN',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
