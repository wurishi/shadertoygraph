import { Config } from '../type'
import fragment from './glsl/4df3RS_14f91b.glsl?raw'
export default [
    {
        // '4df3RS': 'Sobel Edge Detection',
        name: '4df3RS',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
