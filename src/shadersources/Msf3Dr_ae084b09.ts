import { Config } from '../type'
import fragment from './glsl/Msf3Dr_ae084b09.glsl?raw'
export default [

    {
        // 'Msf3Dr': 'Near miss!',
        name: 'Msf3Dr',
        type: 'image',
        fragment,
        channels: [{ "type": "texture", "src": "Stars", "filter": "mipmap", "wrap": "repeat", "noFlip": true }, { "type": "texture", "src": "Organic1", "filter": "mipmap", "wrap": "repeat", "noFlip": true }, { "type": "texture", "src": "Abstract1", "filter": "mipmap", "wrap": "repeat", "noFlip": true }, { "type": "texture", "src": "Lichen", "filter": "mipmap", "wrap": "repeat", "noFlip": true }]
    },
] as Config[]