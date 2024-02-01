import { Config } from '../type'
import fragment from './glsl/ldl3zn.glsl?raw'
export default [
    {
        // 'ldl3zn': 'Timewarp',
        name: 'ldl3zn',
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
            {
                type: 'texture',
                src: 'Wood',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
