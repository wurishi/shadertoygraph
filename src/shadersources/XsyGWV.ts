import { Config } from '../type'

import fragment from './glsl/XsyGWV.glsl?raw'
import A from './glsl/XsyGWV_a.glsl?raw'

export default [
    {
        name: 'XsyGWV',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 0 }],
    },
    {
        name: 'A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'texture', src: 'GrayNoiseMedium' },
            { type: 'buffer', id: 0 },
        ],
    },
] as Config[]
