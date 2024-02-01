import { Config } from '../type'
import fragment from './glsl/Mdl3WH_b49678df.glsl?raw'
export default [
    {
        // 'Mdl3WH': 'Really basic bump mapping',
        name: 'Mdl3WH',
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
