import { Config } from '../type'
import fragment from './glsl/ldX3zS_ad6052b9.glsl?raw'
export default [
    {
        // 'ldX3zS': 'Wavy',
        name: 'ldX3zS',
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
            {
                type: 'texture',
                src: 'Organic2',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
