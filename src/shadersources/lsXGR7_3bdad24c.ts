import { Config } from '../type'
import fragment from './glsl/lsXGR7_3bdad24c.glsl?raw'
export default [
    {
        // 'lsXGR7': 'audiobrot',
        name: 'lsXGR7',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
