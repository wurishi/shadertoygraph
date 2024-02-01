import { Config } from '../type'
import fragment from './glsl/ldX3RH.glsl?raw'
export default [
    {
        // 'ldX3RH': 'sad',
        name: 'ldX3RH',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
