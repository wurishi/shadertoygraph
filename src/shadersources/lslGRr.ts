import { Config } from '../type'
import fragment from './glsl/lslGRr.glsl?raw'
export default [
    {
        // 'lslGRr': 'Sharpen',
        name: 'lslGRr',
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
