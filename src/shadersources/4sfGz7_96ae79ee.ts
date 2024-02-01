import { Config } from '../type'
import fragment from './glsl/4sfGz7_96ae79ee.glsl?raw'
export default [
    {
        // '4sfGz7': 'Trumpet',
        name: '4sfGz7',
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
