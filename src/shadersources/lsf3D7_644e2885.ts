import { Config } from '../type'
import fragment from './glsl/lsf3D7_644e2885.glsl?raw'
export default [
    {
        // 'lsf3D7': 'AudioSurf II',
        name: 'lsf3D7',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
