import { Config } from '../type'
import fragment from './glsl/XlX3Rj.glsl?raw'
export default [
    {
        // 'XlX3Rj': 'Circuits',
        name: 'XlX3Rj',
        type: 'image',
        fragment,
        channels: [
            { type: 'music' },
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
