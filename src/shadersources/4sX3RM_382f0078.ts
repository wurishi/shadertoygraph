import { Config } from '../type'
import fragment from './glsl/4sX3RM_382f0078.glsl?raw'
export default [
    {
        // '4sX3RM': '2d tunnel',
        name: '4sX3RM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Bayer',
                filter: 'nearest',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
