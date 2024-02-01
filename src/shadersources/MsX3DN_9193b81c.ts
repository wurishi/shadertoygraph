import { Config } from '../type'
import fragment from './glsl/MsX3DN_9193b81c.glsl?raw'
export default [
    {
        // 'MsX3DN': 'Simple Sin Wave',
        name: 'MsX3DN',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'London',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
