import { Config } from '../type'
import fragment from './glsl/Xss3zN_f47e1876.glsl?raw'
export default [
    {
        // 'Xss3zN': 'Minefield',
        name: 'Xss3zN',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RustyMetal',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
