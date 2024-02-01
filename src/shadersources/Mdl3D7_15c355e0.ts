import { Config } from '../type'
import fragment from './glsl/Mdl3D7_15c355e0.glsl?raw'
export default [
    {
        // 'Mdl3D7': 'post: Bay Did It!',
        name: 'Mdl3D7',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
