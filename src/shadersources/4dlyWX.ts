import { Config } from '../type'
import fragment from './glsl/4dlyWX.glsl?raw'
import A from './glsl/4dlyWX_A.glsl?raw'
import B from './glsl/4dlyWX_B.glsl?raw'
import C from './glsl/4dlyWX_C.glsl?raw'
import D from './glsl/4dlyWX_D.glsl?raw'
import Common from './glsl/4dlyWX_common.glsl?raw'
import Cube from './glsl/4dlyWX_cube.glsl?raw'
export default [
    {
        // '4dlyWX': 'Meta CRT',
        name: '4dlyWX',
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
            { type: 'keyboard' },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'keyboard' },
            { type: 'texture', src: 'Wood', filter: 'mipmap', wrap: 'repeat' },
        ],
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
            {
                type: 'cubemap',
                map: 'Basilica', // TODO: 应该是自定义的cubemap
                filter: 'linear',
                wrap: 'clamp',
            },
            {
                type: 'texture',
                src: 'RockTiles',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },

    {
        name: 'Buffer D',
        type: 'buffer',
        fragment: D,
        channels: [
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Cube',
        type: 'cubemap',
        fragment: Cube,
        channels: [
            {
                type: 'cubemap',
                map: 'Basilica',
                filter: 'linear',
                wrap: 'clamp',
            },
        ],
    },
    {
        name: 'Common',
        type: 'common',
        fragment: Common,
    },
] as Config[]
