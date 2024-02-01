import { Config } from '../type'
import fragment from './glsl/MsfGzN_935aec7f.glsl?raw'
export default [
    {
        // 'MsfGzN': 'Glass Cubes',
        name: 'MsfGzN',
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
            { type: 'Empty' },
            { type: 'Empty' },
            { type: 'music' },
        ],
    },
] as Config[]
