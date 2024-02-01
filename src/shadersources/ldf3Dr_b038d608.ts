import { Config } from '../type'
import fragment from './glsl/ldf3Dr_b038d608.glsl?raw'
export default [

    {
        // 'ldf3Dr': 'Stereogram',
        name: 'ldf3Dr',
        type: 'image',
        fragment,
        channels: [{ "type": "texture", "src": "Lichen", "filter": "nearest", "wrap": "repeat", "noFlip": true }, { "type": "texture", "src": "GrayNoiseSmall", "filter": "mipmap", "wrap": "repeat", "noFlip": true }]
    },
] as Config[]