import { Config } from '../type'
import fragment from './glsl/XdX3R2_5563e866.glsl?raw'
export default [
    {
        // 'XdX3R2': 'Image Flow',
        name: 'XdX3R2',
        type: 'image',
        fragment,
        channels: [
            { type: 'webcam', filter: 'linear', wrap: 'clamp', noFlip: true },
        ],
    },
] as Config[]
