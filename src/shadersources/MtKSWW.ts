import { Config } from '../type'
import fragment from './glsl/MtKSWW.glsl?raw'
import A from './glsl/MtKSWW_A.glsl?raw'
import B from './glsl/MtKSWW_B.glsl?raw'
import C from './glsl/MtKSWW_C.glsl?raw'
export default [
    {
        // 'MtKSWW': 'Dynamism',
        name: 'MtKSWW',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' }],
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
        channels: [],
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
        ],
    },
] as Config[]
