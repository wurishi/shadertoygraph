import { Config } from '../type'
import fragment from './glsl/lds3R8.glsl?raw'
export default [
    {
        // 'lds3R8': 'motion',
        name: 'lds3R8',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'video' },
        ],
    },
] as Config[]
