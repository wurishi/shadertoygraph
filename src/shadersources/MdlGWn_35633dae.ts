import { Config } from '../type'
import fragment from './glsl/MdlGWn_35633dae.glsl?raw'
export default [

    {
        // 'MdlGWn': 'balls are touching',
        name: 'MdlGWn',
        type: 'image',
        fragment,
        channels: [{ "type": "cubemap", "map": "Forest", "filter": "linear", "wrap": "clamp", "noFlip": true }]
    },
] as Config[]