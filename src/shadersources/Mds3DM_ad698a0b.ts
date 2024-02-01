import { Config } from '../type'
import fragment from './glsl/Mds3DM_ad698a0b.glsl?raw'
export default [
    {
        // 'Mds3DM': 'Black Hole Raytracer',
        name: 'Mds3DM',
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
        ],
    },
] as Config[]
