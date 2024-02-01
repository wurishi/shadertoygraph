import { Config } from '../type'
import fragment from './glsl/MlscDj.glsl?raw'
import A from './glsl/MlscDj_A.glsl?raw'
import B from './glsl/MlscDj_B.glsl?raw'
export default [
    {
        // 'MlscDj': 'Neon World',
        name: 'MlscDj',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
        ],
    },
] as Config[]
