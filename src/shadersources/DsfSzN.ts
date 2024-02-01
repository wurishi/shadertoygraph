import { Config } from '../type'
import fragment from './glsl/DsfSzN.glsl?raw'
export default [
    {
        // 'DsfSzN': 'Silk 3.0',
        name: 'DsfSzN',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
