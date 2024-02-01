import { Config } from '../type'
import fragment from './glsl/ldf3RH.glsl?raw'
export default [
    {
        // 'ldf3RH': 'Music ball',
        name: 'ldf3RH',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
