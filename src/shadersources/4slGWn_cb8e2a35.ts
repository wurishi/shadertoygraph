import { Config } from '../type'
import fragment from './glsl/4slGWn_cb8e2a35.glsl?raw'
export default [

    {
        // '4slGWn': 'Texture - LOD',
        name: '4slGWn',
        type: 'image',
        fragment,
        channels: [{ "type": "texture", "src": "London", "filter": "mipmap", "wrap": "repeat", "noFlip": true }]
    },
] as Config[]