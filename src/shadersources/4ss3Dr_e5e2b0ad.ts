import { Config } from '../type'
import fragment from './glsl/4ss3Dr_e5e2b0ad.glsl?raw'
export default [

    {
        // '4ss3Dr': 'Edge Detection (Sobel kernels)',
        name: '4ss3Dr',
        type: 'image',
        fragment,
        channels: [{ "type": "video" }]
    },
] as Config[]