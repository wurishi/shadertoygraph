import { Config } from '../type'
import fragment from './glsl/XslGRM_6ba86023.glsl?raw'
export default [
    {
        // 'XslGRM': 'Halftone',
        name: 'XslGRM',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
