import { Config } from '../type'
import fragment from './glsl/ldS3Wm.glsl?raw'
export default [
    {
        // 'ldS3Wm': 'doski canady',
        name: 'ldS3Wm',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
