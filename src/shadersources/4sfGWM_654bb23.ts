import { Config } from '../type'
import fragment from './glsl/4sfGWM_654bb23.glsl?raw'
export default [
    {
        // '4sfGWM': 'sobel background',
        name: '4sfGWM',
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
