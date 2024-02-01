import { Config } from '../type'
import fragment from './glsl/Xdl3D8_d667db59.glsl?raw'
export default [
    {
        // 'Xdl3D8': 'Old video',
        name: 'Xdl3D8',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
