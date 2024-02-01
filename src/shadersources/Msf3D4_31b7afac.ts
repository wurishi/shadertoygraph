import { Config } from '../type'
import fragment from './glsl/Msf3D4_31b7afac.glsl?raw'
export default [
    {
        // 'Msf3D4': 'Wobbly',
        name: 'Msf3D4',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
