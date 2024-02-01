import { Config } from '../type'
import fragment from './glsl/4dlGWN_2220416f.glsl?raw'
export default [
    {
        // '4dlGWN': 'Fly into Darkness',
        name: '4dlGWN',
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
