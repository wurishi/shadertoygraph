import { Config } from '../type'
import fragment from './glsl/MscSzf.glsl?raw'
import A from './glsl/MscSzf_A.glsl?raw'
import B from './glsl/MscSzf_B.glsl?raw'
export default [
    {
        // 'MscSzf': 'Noise Contour',
        name: 'MscSzf',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
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
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
