import { Config } from '../type'
import fragment from './glsl/XsfGz7_e998b6cf.glsl?raw'
export default [
    {
        // 'XsfGz7': 'attract tickler',
        name: 'XsfGz7',
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
