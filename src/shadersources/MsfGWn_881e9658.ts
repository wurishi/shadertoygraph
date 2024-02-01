import { Config } from '../type'
import fragment from './glsl/MsfGWn_881e9658.glsl?raw'
export default [

    {
        // 'MsfGWn': 'Circular Tex-Magnification',
        name: 'MsfGWn',
        type: 'image',
        fragment,
        channels: [{ "type": "texture", "src": "London", "filter": "mipmap", "wrap": "repeat", "noFlip": true }]
    },
] as Config[]