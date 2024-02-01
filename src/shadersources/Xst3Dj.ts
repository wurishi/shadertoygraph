import { Config } from '../type'
import fragment from './glsl/Xst3Dj.glsl?raw'
import A from './glsl/Xst3Dj_A.glsl?raw'
export default [
    {
        // 'Xst3Dj': 'Viscous Fingering',
        name: 'Xst3Dj',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            { type: 'Empty' },
            { type: 'keyboard' },
        ],
    },
] as Config[]
