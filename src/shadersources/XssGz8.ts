import { Config } from '../type'
import fragment from './glsl/XssGz8.glsl?raw'
export default [
    {
        // 'XssGz8': 'post: Barrel Blur Chroma',
        name: 'XssGz8',
        type: 'image',
        fragment,
        channels: [
            { type: 'video' },
            {
                type: 'texture',
                src: 'BlueNoise',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
