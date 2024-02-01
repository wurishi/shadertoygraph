import { Config } from '../type'
import fragment from './glsl/XsfGDr_aeeb18ad.glsl?raw'
export default [
    {
        // 'XsfGDr': 'Diamond #1',
        name: 'XsfGDr',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'cubemap',
                map: 'Basilica',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
        ],
    },
] as Config[]
