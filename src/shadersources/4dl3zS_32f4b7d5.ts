import { Config } from '../type'
import fragment from './glsl/4dl3zS_32f4b7d5.glsl?raw'
export default [
    {
        // '4dl3zS': 'Rotated Ball 2D',
        name: '4dl3zS',
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
