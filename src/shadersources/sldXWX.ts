import { Config } from '../type'
import fragment from './glsl/sldXWX.glsl?raw'
import A from './glsl/sldXWX_A.glsl?raw'
export default [
    {
        // 'sldXWX': 'Snowman and The Tree',
        name: 'sldXWX',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'GrayNoiseMedium',
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
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'Empty' },
            {
                type: 'texture',
                src: 'Pebbles',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            {
                type: 'volume',
                volume: 'RGBANoise3D',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
