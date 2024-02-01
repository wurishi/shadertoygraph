import { Config } from '../type'
import fragment from './glsl/lsKfWd.glsl?raw'
import Common from './glsl/lsKfWd_common.glsl?raw'
import A from './glsl/lsKfWd_A.glsl?raw'
import B from './glsl/lsKfWd_B.glsl?raw'
import C from './glsl/lsKfWd_C.glsl?raw'
import D from './glsl/lsKfWd_D.glsl?raw'
export default [
    {
        // 'lsKfWd': 'Quake / Introduction',
        name: 'lsKfWd',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'nearest',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'buffer', id: 3, filter: 'mipmap', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'nearest', wrap: 'clamp' },
        ],
    },

    {
        name: 'Common',
        type: 'common',
        fragment: Common,
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'keyboard' },
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'nearest', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'nearest',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'nearest', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'nearest',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
        ],
    },
] as Config[]
