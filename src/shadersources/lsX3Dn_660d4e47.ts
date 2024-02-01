import { Config } from '../type'
import fragment from './glsl/lsX3Dn_660d4e47.glsl?raw'
export default [

    {
        // 'lsX3Dn': 'Sharpening filter',
        name: 'lsX3Dn',
        type: 'image',
        fragment,
        channels: [{ "type": "texture", "src": "London", "filter": "mipmap", "wrap": "repeat", "noFlip": true }]
    },
] as Config[]