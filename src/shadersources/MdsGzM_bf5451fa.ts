import { Config } from '../type'
import fragment from './glsl/MdsGzM_bf5451fa.glsl?raw'
export default [
    {
        // 'MdsGzM': 'edge glow with box filter',
        name: 'MdsGzM',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
