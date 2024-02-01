import { Config } from '../type'
import fragment from './glsl/Xdf3R4.glsl?raw'
export default [
    {
        // 'Xdf3R4': 'Pseudo Volumetric',
        name: 'Xdf3R4',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
