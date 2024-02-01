import { Config } from '../type'
import fragment from './glsl/4slGDN_910f4b6f.glsl?raw'
export default [
    {
        // '4slGDN': 'Red Sphere Invasion',
        name: '4slGDN',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'cubemap',
                map: 'Gallery',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
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
