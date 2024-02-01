import { Config } from '../type'
import fragment from './glsl/ldsGWn_f1e9acf4.glsl?raw'
export default [

    {
        // 'ldsGWn': 'Random raytracer (unfinished)',
        name: 'ldsGWn',
        type: 'image',
        fragment,
        channels: [{ "type": "cubemap", "map": "Basilica", "filter": "linear", "wrap": "clamp", "noFlip": true }, { "type": "cubemap", "map": "BasilicaBlur", "filter": "linear", "wrap": "clamp", "noFlip": true }]
    },
] as Config[]