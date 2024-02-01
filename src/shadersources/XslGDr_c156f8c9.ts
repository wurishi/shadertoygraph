import { Config } from '../type'
import fragment from './glsl/XslGDr_c156f8c9.glsl?raw'
export default [

    {
        // 'XslGDr': 'Glow hack',
        name: 'XslGDr',
        type: 'image',
        fragment,
        channels: [{ "type": "video" }]
    },
] as Config[]