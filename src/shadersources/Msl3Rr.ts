import { Config } from '../type'

import fragment from './glsl/Msl3Rr.glsl?raw'

export default [
    {
        name: 'Msl3Rr',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }, { type: 'texture', src: 'Wood' }],
    },
] as Config[]
