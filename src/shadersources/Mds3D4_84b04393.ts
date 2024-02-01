import { Config } from '../type'
import fragment from './glsl/Mds3D4_84b04393.glsl?raw'
export default [
    {
        // 'Mds3D4': 'Shadowgrid',
        name: 'Mds3D4',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Organic1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
