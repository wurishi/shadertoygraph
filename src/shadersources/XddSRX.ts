import { Config } from '../type'
import fragment from './glsl/XddSRX.glsl?raw'
import A from './glsl/XddSRX_A.glsl?raw'
export default [
    {
        // 'XddSRX': 'Suture Fluid',
        name: 'XddSRX',
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
