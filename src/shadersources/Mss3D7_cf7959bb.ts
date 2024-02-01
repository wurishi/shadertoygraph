import { Config } from '../type'
import fragment from './glsl/Mss3D7_cf7959bb.glsl?raw'
export default [
    {
        // 'Mss3D7': 'Oldschool plane deformations',
        name: 'Mss3D7',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
