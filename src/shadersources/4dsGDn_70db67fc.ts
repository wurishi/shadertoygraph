import { Config } from '../type'
import fragment from './glsl/4dsGDn_70db67fc.glsl?raw'
export default [

    {
        // '4dsGDn': 'Chromatic Aberration Filter',
        name: '4dsGDn',
        type: 'image',
        fragment,
        channels: [{ "type": "video" }]
    },
] as Config[]