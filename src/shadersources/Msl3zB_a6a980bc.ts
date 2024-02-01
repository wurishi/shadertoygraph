import { Config } from '../type'
import fragment from './glsl/Msl3zB_a6a980bc.glsl?raw'
export default [
    {
        // 'Msl3zB': 'cartoon video',
        name: 'Msl3zB',
        type: 'image',
        fragment,
        channels: [{ type: 'webcam', filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
