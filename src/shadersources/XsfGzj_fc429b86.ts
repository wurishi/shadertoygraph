import { Config } from '../type'
import fragment from './glsl/XsfGzj_fc429b86.glsl?raw'
export default [
    {
        // 'XsfGzj': 'Kaleidoscopic webcam IFS',
        name: 'XsfGzj',
        type: 'image',
        fragment,
        channels: [
            { type: 'webcam', filter: 'linear', wrap: 'clamp', noFlip: true },
        ],
    },
] as Config[]
