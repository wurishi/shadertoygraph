import { Config } from '../type'
import fragment from './glsl/4slGDn_aa616ba7.glsl?raw'
export default [

    {
        // '4slGDn': 'Filter: Desaturation',
        name: '4slGDn',
        type: 'image',
        fragment,
        channels: [{ "type": "video" }]
    },
] as Config[]