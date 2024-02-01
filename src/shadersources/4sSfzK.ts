import { Config } from '../type'
import fragment from './glsl/4sSfzK.glsl?raw'
import A from './glsl/4sSfzK_A.glsl?raw'
export default [
    {
        // '4sSfzK': 'Image',
        name: '4sSfzK',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0 },
            { type: 'cubemap', map: 'BasilicaBlur', noFlip: true },
            { type: 'cubemap', map: 'Basilica', noFlip: true },
            { type: 'texture', src: 'Font1', filter: 'linear', wrap: 'clamp' },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [{ type: 'buffer', id: 0 }],
    },
] as Config[]
