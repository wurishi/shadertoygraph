import { Config } from '../type'
import fragment from './glsl/4dsGR8.glsl?raw'
export default [
    {
        // '4dsGR8': 'Normal Map Filter',
        name: '4dsGR8',
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
