import { Config } from '../type'

import fragment from './glsl/MtX3Ws.glsl?raw'

export default [
    {
        name: 'MtX3Ws',
        type: 'image',
        fragment,
        channels: [{ type: 'cubemap', map: 'Basilica' }],
    },
] as Config[]
