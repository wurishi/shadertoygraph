import { Config } from '../type'
import fragment from './glsl/Msf3RS_fef9ee80.glsl?raw'
export default [
    {
        // 'Msf3RS': 'britneyscope',
        name: 'Msf3RS',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
