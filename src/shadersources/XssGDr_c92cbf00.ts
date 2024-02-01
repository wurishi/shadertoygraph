import { Config } from '../type'
import fragment from './glsl/XssGDr_c92cbf00.glsl?raw'
export default [

    {
        // 'XssGDr': 'Classic tunnel effect',
        name: 'XssGDr',
        type: 'image',
        fragment,
        channels: [{ "type": "texture", "src": "RockTiles", "filter": "mipmap", "wrap": "repeat", "noFlip": true }]
    },
] as Config[]