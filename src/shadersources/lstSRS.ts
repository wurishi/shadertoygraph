import { Config } from '../type'
import fragment from './glsl/lstSRS.glsl?raw'
import A from './glsl/lstSRS_A.glsl?raw'
import B from './glsl/lstSRS_B.glsl?raw'
import C from './glsl/lstSRS_C.glsl?raw'
import D from './glsl/lstSRS_D.glsl?raw'
export default [
    {
        // 'lstSRS': 'Gargantua With HDR Bloom',
        name: 'lstSRS',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            {
                type: 'texture',
                src: 'Organic1',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
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
        channels: [{ type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [{ type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
