import { Config } from '../type'
import fragment from './glsl/lssGDn_42c6a6f4.glsl?raw'
export default [

    {
        // 'lssGDn': 'Pseudo 3D Tunnel',
        name: 'lssGDn',
        type: 'image',
        fragment,
        channels: [{ "type": "texture", "src": "RockTiles", "filter": "mipmap", "wrap": "repeat", "noFlip": true }]
    },
] as Config[]