import { Config } from '../type'
import fragment from './glsl/XsfGWM_79627402.glsl?raw'
export default [
    {
        // 'XsfGWM': 'pivot dance',
        name: 'XsfGWM',
        type: 'image',
        fragment,
        channels: [
            { type: 'video' },
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
