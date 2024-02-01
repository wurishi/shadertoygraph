import { Config } from '../type'
import fragment from './glsl/4dlGR8.glsl?raw'
export default [
    {
        // '4dlGR8': 'ChaosTrend logo',
        name: '4dlGR8',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RustyMetal',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
