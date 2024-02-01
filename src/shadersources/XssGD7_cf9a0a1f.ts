import { Config } from '../type'
import fragment from './glsl/XssGD7_cf9a0a1f.glsl?raw'
export default [
    {
        // 'XssGD7': 'Webcam edge glow',
        name: 'XssGD7',
        type: 'image',
        fragment,
        channels: [{ type: 'webcam', filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
