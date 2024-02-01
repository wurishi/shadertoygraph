import { Config } from '../type'
import fragment from './glsl/XsX3R2_87a3a3f4.glsl?raw'
export default [
    {
        // 'XsX3R2': 'Grass',
        name: 'XsX3R2',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
