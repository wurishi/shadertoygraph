import { Config } from '../type'

import fragment from './glsl/ldXXDj.glsl?raw'
import S from './glsl/ldXXDj_s.glsl?raw'

export default [
    {
        name: 'ldXXDj',
        type: 'image',
        fragment,
        channels: [
            { type: 'texture', src: 'Stars' },
            { type: 'texture', src: 'GrayNoiseMedium' },
        ],
    },
    {
        name: 'Sound',
        type: 'sound',
        fragment: S,
    },
] as Config[]
