import { Config } from '../type'
import fragment from './glsl/4sf3W8_75c3fe1c.glsl?raw'
export default [
    {
        // '4sf3W8': 'Simple Edge Detector',
        name: '4sf3W8',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
