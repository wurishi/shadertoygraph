import { Config } from '../type'
import fragment from './glsl/XllGW4.glsl?raw'
export default [
    {
        // 'XllGW4': 'HOWTO: Ray Marching',
        name: 'XllGW4',
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
