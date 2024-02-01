import { Config } from '../type'
import fragment from './glsl/Xdl3WH_e78debf7.glsl?raw'
export default [
    {
        // 'Xdl3WH': 'Brick Vortex',
        name: 'Xdl3WH',
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
