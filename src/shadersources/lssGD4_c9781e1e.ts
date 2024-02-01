import { Config } from '../type'
import fragment from './glsl/lssGD4_c9781e1e.glsl?raw'
export default [
    {
        // 'lssGD4': 'cubemap to fisheye',
        name: 'lssGD4',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'cubemap',
                map: 'Gallery',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
            {
                type: 'cubemap',
                map: 'Basilica',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
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
