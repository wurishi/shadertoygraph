import { Config } from '../type'
import fragment from './glsl/XdfGzj_2e82d014.glsl?raw'
export default [
    {
        // 'XdfGzj': 'Spiral Repetition',
        name: 'XdfGzj',
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
            {
                type: 'cubemap',
                map: 'BasilicaBlur',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
        ],
    },
] as Config[]
