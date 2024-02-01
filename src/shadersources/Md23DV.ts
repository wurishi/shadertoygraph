import { Config } from '../type'

import fragment from './glsl/Md23DV.glsl?raw'

export default [
    {
        name: 'Md23DV',
        type: 'image',
        fragment,
        channels: [
            { type: 'texture', src: 'GrayNoiseMedium' },
            { type: 'texture', src: 'RockTiles' },
            { type: 'texture', src: 'RustyMetal' },
        ],
    },
] as Config[]
