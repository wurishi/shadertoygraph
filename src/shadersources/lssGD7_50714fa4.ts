import { Config } from '../type'
import fragment from './glsl/lssGD7_50714fa4.glsl?raw'
export default [
    {
        // 'lssGD7': 'TV Snow',
        name: 'lssGD7',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
