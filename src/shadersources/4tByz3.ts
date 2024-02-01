import { Config } from '../type'
import fragment from './glsl/4tByz3.glsl?raw'
import A from './glsl/4tByz3_A.glsl?raw'
export default [
    {
        // '4tByz3': 'Ladybug',
        name: '4tByz3',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'Empty' },
            {
                type: 'texture',
                src: 'Organic2',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
