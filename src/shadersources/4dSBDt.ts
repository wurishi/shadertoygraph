import { Config } from '../type'
import fragment from './glsl/4dSBDt.glsl?raw'
import A from './glsl/4dSBDt_A.glsl?raw'
import B from './glsl/4dSBDt_B.glsl?raw'
import C from './glsl/4dSBDt_C.glsl?raw'
export default [
    {
        // '4dSBDt': 'Enscape Cube',
        name: '4dSBDt',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            {
                type: 'texture',
                src: 'Pebbles',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'volume', volume: 'GreyNoise3D' },
            {
                type: 'texture',
                src: 'GrayNoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
        ],
    },
] as Config[]
