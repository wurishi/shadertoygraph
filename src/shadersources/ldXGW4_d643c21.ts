import { Config } from '../type'
import fragment from './glsl/ldXGW4_d643c21.glsl?raw'
export default [
    {
        // 'ldXGW4': 'Distorted TV',
        name: 'ldXGW4',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
