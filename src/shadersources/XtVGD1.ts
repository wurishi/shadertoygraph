import { Config } from '../type'

import fragment from './glsl/XtVGD1.glsl?raw'

export default [
    {
        name: 'XtVGD1',
        type: 'image',
        fragment,
        channels: [
            { type: 'video' },
            { type: 'texture', src: 'RGBANoiseMedium' },
        ],
    },
] as Config[]
