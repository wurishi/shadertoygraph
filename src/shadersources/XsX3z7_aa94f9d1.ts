import { Config } from '../type'
import fragment from './glsl/XsX3z7_aa94f9d1.glsl?raw'
export default [
    {
        // 'XsX3z7': 'Kaleidoscopic Journey',
        name: 'XsX3z7',
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
