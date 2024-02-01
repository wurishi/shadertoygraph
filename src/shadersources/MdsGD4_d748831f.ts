import { Config } from '../type'
import fragment from './glsl/MdsGD4_d748831f.glsl?raw'
export default [
    {
        // 'MdsGD4': 'Simple raymarcher',
        name: 'MdsGD4',
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
