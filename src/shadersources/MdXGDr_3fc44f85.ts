import { Config } from '../type'
import fragment from './glsl/MdXGDr_3fc44f85.glsl?raw'
export default [

    {
        // 'MdXGDr': 'Data Transfer',
        name: 'MdXGDr',
        type: 'image',
        fragment,
        channels: [{ "type": "cubemap", "map": "Gallery", "filter": "linear", "wrap": "clamp", "noFlip": true }]
    },
] as Config[]