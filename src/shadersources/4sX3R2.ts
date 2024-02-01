import { Config } from '../type'
import fragment from './glsl/4sX3R2.glsl?raw'
export default [
    {
        // '4sX3R2': 'Monster',
        name: '4sX3R2',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'cubemap',
                map: 'Forest',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
        ],
    },
] as Config[]
