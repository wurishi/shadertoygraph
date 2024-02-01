import { Config } from '../type'
import fragment from './glsl/4sX3Wr_f33ed900.glsl?raw'
export default [
    {
        // '4sX3Wr': 'Water columns',
        name: '4sX3Wr',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RustyMetal',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
