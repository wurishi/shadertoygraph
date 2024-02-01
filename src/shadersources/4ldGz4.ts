import { Config } from '../type'
import fragment from './glsl/4ldGz4.glsl?raw'
import A from './glsl/4ldGz4_A.glsl?raw'
import B from './glsl/4ldGz4_B.glsl?raw'
export default [
    {
        // '4ldGz4': '[SH16B] Speed Drive 80',
        name: '4ldGz4',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            {
                type: 'texture',
                src: 'GrayNoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            { type: 'Empty' },
            { type: 'Empty' },
            { type: 'music' },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
