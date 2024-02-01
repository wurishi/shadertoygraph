import { Config } from '../type'
import fragment from './glsl/4dlGDr_6ca07c7a.glsl?raw'
export default [

    {
        // '4dlGDr': 'Filter: Box Blur',
        name: '4dlGDr',
        type: 'image',
        fragment,
        channels: [{ "type": "video" }]
    },
] as Config[]