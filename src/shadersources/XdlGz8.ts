import { Config } from '../type'
import fragment from './glsl/XdlGz8.glsl?raw'
export default [
    {
        // 'XdlGz8': 'Emboss',
        name: 'XdlGz8',
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
