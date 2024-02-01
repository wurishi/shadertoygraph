import { Config } from '../type'
import fragment from './glsl/lscBW4.glsl?raw'
import Common from './glsl/lscBW4_common.glsl?raw'
import A from './glsl/lscBW4_A.glsl?raw'
import B from './glsl/lscBW4_B.glsl?raw'
export default [
    {
        // 'lscBW4': 'Old watch (IBL)',
        name: 'lscBW4',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'cubemap',
                map: 'Gallery',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'texture', src: 'Wood', filter: 'mipmap', wrap: 'repeat' },
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
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
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'texture', src: 'Font1', filter: 'mipmap', wrap: 'repeat' },
            {
                type: 'texture',
                src: 'Organic3',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [{ type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
