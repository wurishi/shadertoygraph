import { Config } from '../type'
import fragment from './glsl/Xsf3R4.glsl?raw'
export default [
    {
        // 'Xsf3R4': 'CircleMapping',
        name: 'Xsf3R4',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RockTiles',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
