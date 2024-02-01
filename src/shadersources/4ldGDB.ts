import { Config } from '../type'
import fragment from './glsl/4ldGDB.glsl?raw'
import A from './glsl/4ldGDB_A.glsl?raw'
import B from './glsl/4ldGDB_B.glsl?raw'
export default [
    {
        // '4ldGDB': 'Displacement with Dispersion',
        name: '4ldGDB',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'London',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            { type: 'Empty' },
            { type: 'keyboard' },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
