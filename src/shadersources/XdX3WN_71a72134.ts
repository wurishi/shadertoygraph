import { Config } from '../type'
import fragment from './glsl/XdX3WN_71a72134.glsl?raw'
export default [
    {
        // 'XdX3WN': 'Plasma Triangle',
        name: 'XdX3WN',
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
