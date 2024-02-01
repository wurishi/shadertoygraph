import { Config } from '../type'
import fragment from './glsl/lty3Rt.glsl?raw'
export default [
    {
        // 'lty3Rt': 'Pegasus Galaxy',
        name: 'lty3Rt',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
