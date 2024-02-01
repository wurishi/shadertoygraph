import { Config } from '../type'
import fragment from './glsl/llsGW7.glsl?raw'
export default [
    {
        // 'llsGW7': '[2TC 15] Mystery Mountains',
        name: 'llsGW7',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Organic1',
                filter: 'linear',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'music',
            },
        ],
    },
] as Config[]
