import { Config } from '../type'
import fragment from './glsl/Xss3D4_56b9b29.glsl?raw'
export default [
    {
        // 'Xss3D4': 'AcidWobble',
        name: 'Xss3D4',
        type: 'image',
        fragment,
        channels: [
            { type: 'webcam', filter: 'linear', wrap: 'clamp', noFlip: true },
        ],
    },
] as Config[]
