import { Config } from '../type'
import fragment from './glsl/Msf3z4_7072b4d1.glsl?raw'
export default [
    {
        // 'Msf3z4': 'Reprojection II',
        name: 'Msf3z4',
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
