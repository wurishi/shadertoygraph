import { Config } from '../type'
import fragment from './glsl/DdXXzN.glsl?raw'
import B from './glsl/DdXXzN_B.glsl?raw'
export default [
    {
        // 'DdXXzN': 'Test Erosion Algo',
        name: 'DdXXzN',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'repeat' }],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'Empty' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'linear',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'buffer', id: 0, filter: 'mipmap', wrap: 'repeat' },
            {
                type: 'texture',
                src: 'Abstract3',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
