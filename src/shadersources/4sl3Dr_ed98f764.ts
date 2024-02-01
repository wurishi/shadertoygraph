import { Config } from '../type'
import fragment from './glsl/4sl3Dr_ed98f764.glsl?raw'
export default [
    {
        // '4sl3Dr': 'Digital Brain',
        name: '4sl3Dr',
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
