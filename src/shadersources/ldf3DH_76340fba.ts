import { Config } from '../type'
import fragment from './glsl/ldf3DH_76340fba.glsl?raw'
export default [
    {
        // 'ldf3DH': 'spike donut',
        name: 'ldf3DH',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
