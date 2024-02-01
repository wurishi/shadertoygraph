import { Config } from '../type'
import fragment from './glsl/MsXGWr_8ceb4585.glsl?raw'
export default [

    {
        // 'MsXGWr': 'Mike',
        name: 'MsXGWr',
        type: 'image',
        fragment,
        channels: [{ "type": "texture", "src": "RGBANoiseSmall", "filter": "mipmap", "wrap": "repeat", "noFlip": true }]
    },
] as Config[]