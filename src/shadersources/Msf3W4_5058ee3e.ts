import { Config } from '../type'
import fragment from './glsl/Msf3W4_5058ee3e.glsl?raw'
export default [
    {
        // 'Msf3W4': 'Math2CV-Edge scanner',
        name: 'Msf3W4',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
