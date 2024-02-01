import { Config } from '../type'
import fragment from './glsl/MdSczK.glsl?raw'
import A from './glsl/MdSczK_A.glsl?raw'
import B from './glsl/MdSczK_B.glsl?raw'
import C from './glsl/MdSczK_C.glsl?raw'
import D from './glsl/MdSczK_D.glsl?raw'
export default [
    {
        // 'MdSczK': 'Multistep Fluid Simulation',
        name: 'MdSczK',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
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
        channels: [
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
        ],
    },
] as Config[]
