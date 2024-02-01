import { Config } from '../type'
import fragment from './glsl/XlB3zV.glsl?raw'
export default [
    {
        // 'XlB3zV': 'Magnetismic',
        name: 'XlB3zV',
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
