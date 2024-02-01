import { Config } from '../type'
import fragment from './glsl/Mdf3zr.glsl?raw'
export default [
    {
        // 'Mdf3zr': 'edge glow',
        name: 'Mdf3zr',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
