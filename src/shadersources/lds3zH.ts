import { Config } from '../type'
import fragment from './glsl/lds3zH.glsl?raw'
export default [
    {
        // 'lds3zH': 'WaveTransion',
        name: 'lds3zH',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
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
