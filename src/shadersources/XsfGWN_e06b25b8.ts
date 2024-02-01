import { Config } from '../type'
import fragment from './glsl/XsfGWN_e06b25b8.glsl?raw'
export default [
    {
        // 'XsfGWN': 'furball',
        name: 'XsfGWN',
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
