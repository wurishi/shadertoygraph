import { Config } from '../type'
import fragment from './glsl/ldl3zN_b12f5196.glsl?raw'
export default [
    {
        // 'ldl3zN': 'Piano',
        name: 'ldl3zN',
        type: 'image',
        fragment,
        channels: [
            { type: 'Empty' },
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
