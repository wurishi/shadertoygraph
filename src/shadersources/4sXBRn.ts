import { Config } from '../type'
import fragment from './glsl/4sXBRn.glsl?raw'
export default [
    {
        // '4sXBRn': 'Luminescence',
        name: '4sXBRn',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
