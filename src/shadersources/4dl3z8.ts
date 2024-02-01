import { Config } from '../type'
import fragment from './glsl/4dl3z8.glsl?raw'
export default [
    {
        // '4dl3z8': 'Radial Chroma Blur',
        name: '4dl3z8',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
