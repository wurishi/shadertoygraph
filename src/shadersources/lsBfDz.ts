import { Config } from '../type'
import fragment from './glsl/lsBfDz.glsl?raw'
export default [
    {
        // 'lsBfDz': '[SH17A] Tiny Clouds',
        name: 'lsBfDz',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'linear',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'music' },
        ],
    },
] as Config[]
