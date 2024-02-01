import { Config } from '../type'
import fragment from './glsl/MslGzM_65ee5da1.glsl?raw'
export default [
    {
        // 'MslGzM': '2D Cell PostEffect',
        name: 'MslGzM',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
