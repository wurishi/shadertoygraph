import { Config } from '../type'

import fragment from './glsl/XtS3DD.glsl?raw'

export default [
    {
        name: 'XtS3DD',
        type: 'image',
        fragment,
        channels: [{ type: 'texture', src: 'RGBANoiseMedium' }],
    },
] as Config[]
