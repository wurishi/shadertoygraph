import { Config } from '../type'
import fragment from './glsl/4s3SRN.glsl?raw'
export default [
    {
        // '4s3SRN': 'Fractal Flythrough',
        name: '4s3SRN',
        type: 'image',
        fragment,
        channels: [
            { type: 'texture', src: 'Wood', filter: 'mipmap', wrap: 'repeat' },
        ],
    },
] as Config[]
