import { Config } from '../type'
import fragment from './glsl/MdXGzB_58d86454.glsl?raw'
export default [
    {
        // 'MdXGzB': 'aawerawerwae',
        name: 'MdXGzB',
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
