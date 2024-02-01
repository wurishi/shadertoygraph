import { Config } from '../type'
import fragment from './glsl/XslGz8.glsl?raw'
export default [
    {
        // 'XslGz8': 'Barrel Blur',
        name: 'XslGz8',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
