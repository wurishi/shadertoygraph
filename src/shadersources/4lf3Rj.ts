import { Config } from '../type'
import fragment from './glsl/4lf3Rj.glsl?raw'
export default [
    {
        // '4lf3Rj': 'Hot Shower',
        name: '4lf3Rj',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'GrayNoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Lichen',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
