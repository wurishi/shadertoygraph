import { Config } from '../type'
import fragment from './glsl/csfSzN.glsl?raw'
export default [
    {
        // 'csfSzN': 'Silk 2.0',
        name: 'csfSzN',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
