import { Config } from '../type'
import fragment from './glsl/lsf3Dn_76f9c1d5.glsl?raw'
export default [

    {
        // 'lsf3Dn': 'Rays of Blinding Light',
        name: 'lsf3Dn',
        type: 'image',
        fragment,
        channels: [{ "type": "texture", "src": "Abstract1", "filter": "mipmap", "wrap": "repeat", "noFlip": true }]
    },
] as Config[]