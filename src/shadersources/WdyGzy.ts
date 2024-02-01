import { Config } from '../type'
import fragment from './glsl/WdyGzy.glsl?raw'
import A from './glsl/WdyGzy_A.glsl?raw'
import D from './glsl/WdyGzy_D.glsl?raw'
import B from './glsl/WdyGzy_B.glsl?raw'
import C from './glsl/WdyGzy_C.glsl?raw'
export default [
    {
        // 'WdyGzy': 'Lattice Boltzmann ',
        name: 'WdyGzy',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'Empty' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'Lichen',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [{ type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
