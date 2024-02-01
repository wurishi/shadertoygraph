import { Config } from '../type'
import fragment from './glsl/MslGWn_e7a3763c.glsl?raw'
export default [

    {
        // 'MslGWn': '2D Distortion hack1',
        name: 'MslGWn',
        type: 'image',
        fragment,
        channels: [{ "type": "texture", "src": "Abstract1", "filter": "mipmap", "wrap": "repeat", "noFlip": true }]
    },
] as Config[]