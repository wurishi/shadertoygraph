import { Config } from '../type'
import fragment from './glsl/ldfGWn_962e0b59.glsl?raw'
export default [
    {
        // 'ldfGWn': 'Truchet Tentacles',
        name: 'ldfGWn',
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
