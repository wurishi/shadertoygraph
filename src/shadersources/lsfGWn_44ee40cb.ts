import { Config } from '../type'
import fragment from './glsl/lsfGWn_44ee40cb.glsl?raw'
export default [

    {
        // 'lsfGWn': 'Blur: Poisson Disc',
        name: 'lsfGWn',
        type: 'image',
        fragment,
        channels: [{ "type": "texture", "src": "London", "filter": "mipmap", "wrap": "repeat", "noFlip": true }, { "type": "Empty" }, { "type": "Empty" }, { "type": "texture", "src": "BlueNoise", "filter": "mipmap", "wrap": "repeat" }]
    },
] as Config[]