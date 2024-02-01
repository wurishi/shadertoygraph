import { Config } from '../type'
import fragment from './glsl/Mdf3R8.glsl?raw'
export default [
    {
        // 'Mdf3R8': '2D simple white point light',
        name: 'Mdf3R8',
        type: 'image',
        fragment,
        channels: [
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
