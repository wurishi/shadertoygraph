import { Config } from '../type'
import fragment from './glsl/lsf3Rj_6d0cb01b.glsl?raw'
export default [
    {
        // 'lsf3Rj': 'Scharr Filter',
        name: 'lsf3Rj',
        type: 'image',
        fragment,
        channels: [
            { type: 'webcam', filter: 'linear', wrap: 'clamp', noFlip: true },
        ],
    },
] as Config[]
