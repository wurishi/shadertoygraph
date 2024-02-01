import { Config } from '../type'
import fragment from './glsl/MdfGzj_7d99433c.glsl?raw'
export default [
    {
        // 'MdfGzj': 'Flying Spheres',
        name: 'MdfGzj',
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
