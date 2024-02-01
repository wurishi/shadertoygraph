import { Config } from '../type'

import fragment from './glsl/WsSBzh.glsl?raw'
import a from './glsl/WsSBzh_a.glsl?raw'
import b from './glsl/WsSBzh_b.glsl?raw'
import co from './glsl/WsSBzh_co.glsl?raw'

export default [
    {
        type: 'common',
        fragment: co,
    },
    {
        name: 'WsSBzh',
        type: 'image',
        fragment,
        channels: [
            { type: 'volume', volume: 'GreyNoise3D' },
            { type: 'buffer', id: 1 },
            { type: 'texture', src: 'GrayNoiseSmall' },
            { type: 'texture', src: 'RGBANoiseMedium' },
        ],
    },
    {
        name: 'a',
        type: 'buffer',
        fragment: a,
        channels: [
            { type: 'volume', volume: 'GreyNoise3D' },
            { type: 'buffer', id: 0 },
            { type: 'texture', src: 'GrayNoiseSmall' },
            { type: 'texture', src: 'RGBANoiseMedium' },
        ],
    },
    {
        name: 'b',
        type: 'buffer',
        fragment: b,
        channels: [{ type: 'buffer', id: 0 }],
    },
] as Config[]
