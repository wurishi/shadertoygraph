import { Config } from '../type'
import fragment from './glsl/Wtc3W2.glsl?raw'
import Common from './glsl/Wtc3W2_common.glsl?raw'
import A from './glsl/Wtc3W2_A.glsl?raw'
export default [
    {
        // 'Wtc3W2': 'Campfire at night',
        name: 'Wtc3W2',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 0, filter: 'mipmap', wrap: 'clamp' }],
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
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'Organic4',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            {
                type: 'texture',
                src: 'Lichen',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            {
                type: 'cubemap',
                map: 'Forest',
                filter: 'mipmap',
                wrap: 'clamp',
                noFlip: true,
            },
        ],
    },
] as Config[]
