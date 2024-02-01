import { Config } from '../type'
import fragment from './glsl/MtcGDH.glsl?raw'
import A from './glsl/MtcGDH_A.glsl?raw'
import B from './glsl/MtcGDH_B.glsl?raw'
import C from './glsl/MtcGDH_C.glsl?raw'
import D from './glsl/MtcGDH_D.glsl?raw'
export default [
    {
        // 'MtcGDH': '[SH16C] Voxel Game',
        name: 'MtcGDH',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            { type: 'keyboard' },
            { type: 'buffer', id: 2, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 3, filter: 'nearest', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
            { type: 'keyboard' },
            { type: 'music' },
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

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'nearest',
                wrap: 'repeat',
            },
            { type: 'buffer', id: 2, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [
            { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'nearest', wrap: 'clamp' },
            { type: 'buffer', id: 3, filter: 'nearest', wrap: 'clamp' },
        ],
    },
] as Config[]
