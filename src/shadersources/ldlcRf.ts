import { Config } from '../type'

import fragment from './glsl/ldlcRf.glsl?raw'

export default [
    {
        type: 'image',
        fragment,
        channels: [
            { type: 'texture', src: 'Font1', filter: 'linear' },
            { type: 'texture', src: 'GrayNoiseMedium' },
            { type: 'music' },
        ],
    },
] as Config[]
