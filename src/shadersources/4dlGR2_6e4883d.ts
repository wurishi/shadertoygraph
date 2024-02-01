import { Config } from '../type'
import fragment from './glsl/4dlGR2_6e4883d.glsl?raw'
export default [
    {
        // '4dlGR2': 'fire fast',
        name: '4dlGR2',
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
