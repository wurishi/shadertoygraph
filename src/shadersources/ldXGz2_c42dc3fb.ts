import { Config } from '../type'
import fragment from './glsl/ldXGz2_c42dc3fb.glsl?raw'
export default [
    {
        // 'ldXGz2': 'SGI Logo',
        name: 'ldXGz2',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'cubemap',
                map: 'GalleryB',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
        ],
    },
] as Config[]
