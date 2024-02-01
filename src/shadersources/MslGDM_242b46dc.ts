import { Config } from '../type'
import fragment from './glsl/MslGDM_242b46dc.glsl?raw'
export default [
    {
        // 'MslGDM': 'Almost a lens',
        name: 'MslGDM',
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
