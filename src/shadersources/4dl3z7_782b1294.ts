import { Config } from '../type'
import fragment from './glsl/4dl3z7_782b1294.glsl?raw'
export default [

    {
        // '4dl3z7': 'Haunted Forest',
        name: '4dl3z7',
        type: 'image',
        fragment,
        channels: [{ "type": "texture", "src": "Lichen", "filter": "mipmap", "wrap": "repeat", "noFlip": true }]
    },
] as Config[]