import { Config } from '../type'
import fragment from './glsl/lds3z8.glsl?raw'
export default [
    {
        // 'lds3z8': '1000 Spheres remake from 1995',
        name: 'lds3z8',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Abstract2',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Stars',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
