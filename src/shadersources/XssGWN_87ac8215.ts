import { Config } from '../type'
import fragment from './glsl/XssGWN_87ac8215.glsl?raw'
export default [
    {
        // 'XssGWN': 'Planet Funk',
        name: 'XssGWN',
        type: 'image',
        fragment,
        channels: [
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
