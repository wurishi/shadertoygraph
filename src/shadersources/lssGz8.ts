import { Config } from '../type'
import fragment from './glsl/lssGz8.glsl?raw'
export default [
    {
        // 'lssGz8': 'Metamaterial',
        name: 'lssGz8',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
