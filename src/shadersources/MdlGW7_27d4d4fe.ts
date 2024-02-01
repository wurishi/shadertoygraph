import { Config } from '../type'
import fragment from './glsl/MdlGW7_27d4d4fe.glsl?raw'
import A from './glsl/MdlGW7_27d4d4fe_A.glsl?raw'
export default [
    {
        // 'MdlGW7': 'Cloudy Terrain',
        name: 'MdlGW7',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            {
                type: 'texture',
                src: 'GrayNoiseMedium',
                filter: 'linear',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RGBANoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
