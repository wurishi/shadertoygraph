import { Config } from '../type'

import fragment from './glsl/ldlXRS.glsl?raw'

export default [
    {
        name: 'ldlXRS',
        type: 'image',
        fragment,
        channels: [{ type: 'texture', src: 'GrayNoiseMedium' }],
    },
] as Config[]
