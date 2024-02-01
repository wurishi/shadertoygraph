import { Config } from '../type'

import Fragment from './glsl/MsGSRd.glsl?raw'
import A from './glsl/MsGSRd_a.glsl?raw'

export default [
    {
        name: 'MsGSRd',
        type: 'image',
        fragment: Fragment,
        channels: [{ type: 'buffer', id: 0 }],
    },
    {
        name: 'buffer',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 0 },
            { type: 'texture', src: 'RGBANoiseMedium' },
            { type: 'texture', src: 'London' },
            { type: 'keyboard' },
        ],
    },
] as Config[]
