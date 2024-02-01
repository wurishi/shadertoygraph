import { Config } from '../type'
import fragment from './glsl/4df3zH.glsl?raw'
export default [
    {
        // '4df3zH': 'half sphere lens distortion',
        name: '4df3zH',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
