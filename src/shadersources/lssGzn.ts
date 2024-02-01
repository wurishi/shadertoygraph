import { Config } from '../type'
import fragment from './glsl/lssGzn.glsl?raw'
export default [
    {
        // 'lssGzn': 'Coffee and Tablet',
        name: 'lssGzn',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Wood',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'video' },
            {
                type: 'texture',
                src: 'Nyancat',
                filter: 'nearest',
                wrap: 'clamp',
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
