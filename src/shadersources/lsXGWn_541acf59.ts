import { Config } from '../type'
import fragment from './glsl/lsXGWn_541acf59.glsl?raw'
export default [
    {
        // 'lsXGWn': 'Simple Bloom/Glow (white)',
        name: 'lsXGWn',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Stars',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
