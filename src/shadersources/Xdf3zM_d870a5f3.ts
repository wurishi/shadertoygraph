import { Config } from '../type'
import fragment from './glsl/Xdf3zM_d870a5f3.glsl?raw'
export default [
    {
        // 'Xdf3zM': 'Shard',
        name: 'Xdf3zM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'cubemap',
                map: 'Gallery',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
            { type: 'music' },
        ],
    },
] as Config[]
