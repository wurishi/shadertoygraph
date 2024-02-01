import { Config } from '../type'
import fragment from './glsl/ldXGDr_f3349916.glsl?raw'
export default [

    {
        // 'ldXGDr': 'Flatland',
        name: 'ldXGDr',
        type: 'image',
        fragment,
        channels: [{ "type": "texture", "src": "Pebbles", "filter": "mipmap", "wrap": "repeat" }, { "type": "texture", "src": 'Abstract3', "filter": "mipmap", "wrap": "repeat" }]
    },
] as Config[]