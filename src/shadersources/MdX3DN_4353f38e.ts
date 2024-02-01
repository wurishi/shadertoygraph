import { Config } from '../type'
import fragment from './glsl/MdX3DN_4353f38e.glsl?raw'
export default [
    {
        // 'MdX3DN': 'Transition: Fade',
        name: 'MdX3DN',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RustyMetal',
                filter: 'mipmap',
                wrap: 'repeat',
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
