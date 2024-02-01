import { Config } from '../type'
import fragment from './glsl/4sGSDw.glsl?raw'
import A from './glsl/4sGSDw_A.glsl?raw'
import B from './glsl/4sGSDw_B.glsl?raw'
export default [
    {
        // '4sGSDw': 'Sinuous',
        name: '4sGSDw',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
        ],
    },
] as Config[]
