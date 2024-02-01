import { Config } from '../type'
import fragment from './glsl/lscczl.glsl?raw'
export default [
    {
        // 'lscczl': 'The Universe Within',
        name: 'lscczl',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
