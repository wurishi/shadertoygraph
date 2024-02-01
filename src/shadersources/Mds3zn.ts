import { Config } from '../type'
import fragment from './glsl/Mds3zn.glsl?raw'
export default [
    {
        // 'Mds3zn': 'Chromatic Aberration',
        name: 'Mds3zn',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
