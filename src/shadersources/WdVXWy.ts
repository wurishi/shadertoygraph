import { Config } from '../type'
import fragment from './glsl/WdVXWy.glsl?raw'
import A from './glsl/WdVXWy_A.glsl?raw'
import B from './glsl/WdVXWy_B.glsl?raw'
import Common from './glsl/WdVXWy_common.glsl?raw'
export default [
    {
        // 'WdVXWy': 'molten bismuth',
        name: 'WdVXWy',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'repeat' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            {
                type: 'cubemap',
                map: 'ForestBlur',
                filter: 'mipmap',
                wrap: 'clamp',
                noFlip: true,
            },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'repeat' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            { type: 'keyboard' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer B',
        type: 'buffer',
        fragment: B,
        channels: [{ type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Common',
        type: 'common',
        fragment: Common,
    },
] as Config[]
