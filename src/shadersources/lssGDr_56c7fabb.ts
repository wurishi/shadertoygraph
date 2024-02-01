import { Config } from '../type'
import fragment from './glsl/lssGDr_56c7fabb.glsl?raw'
export default [
    {
        // 'lssGDr': 'Simple plane walkthrough',
        name: 'lssGDr',
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
