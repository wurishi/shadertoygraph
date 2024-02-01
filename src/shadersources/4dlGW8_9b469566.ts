import { Config } from '../type'
import fragment from './glsl/4dlGW8_9b469566.glsl?raw'
export default [
    {
        // '4dlGW8': 'Eye sketch',
        name: '4dlGW8',
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
        ],
    },
] as Config[]
