import { Config } from '../type'
import fragment from './glsl/MslGW7_f5149f6c.glsl?raw'
export default [
    {
        // 'MslGW7': 'Interval mapping',
        name: 'MslGW7',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
