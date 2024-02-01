import { Config } from '../type'
import fragment from './glsl/XdcGWS.glsl?raw'
import A from './glsl/XdcGWS_A.glsl?raw'
import B from './glsl/XdcGWS_B.glsl?raw'
import C from './glsl/XdcGWS_C.glsl?raw'
export default [
    {
        // 'XdcGWS': 'Shader Rally',
        name: 'XdcGWS',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
        ],
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
            { type: 'buffer', id: 1, filter: 'nearest', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer C',
        type: 'buffer',
        fragment: C,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'Organic4',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            { type: 'texture', src: 'Wood', filter: 'mipmap', wrap: 'repeat' },
            { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
        ],
    },
] as Config[]
