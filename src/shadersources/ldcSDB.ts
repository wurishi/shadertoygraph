import { Config } from '../type'
import fragment from './glsl/ldcSDB.glsl?raw'
import A from './glsl/ldcSDB_A.glsl?raw'
import B from './glsl/ldcSDB_B.glsl?raw'
export default [
    {
        // 'ldcSDB': 'Anisotropic Blur Image Warp',
        name: 'ldcSDB',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            { type: 'Empty' },
            { type: 'keyboard' },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            {
                type: 'texture',
                src: 'Abstract3',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'keyboard' },
        ],
    },
] as Config[]
