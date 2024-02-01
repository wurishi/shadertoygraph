import { Config } from '../type'
import fragment from './glsl/MslGz4_4c379439.glsl?raw'
export default [
    {
        // 'MslGz4': '3d blobs',
        name: 'MslGz4',
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
