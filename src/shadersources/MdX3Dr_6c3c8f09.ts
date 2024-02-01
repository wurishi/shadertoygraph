import { Config } from '../type'
import fragment from './glsl/MdX3Dr_6c3c8f09.glsl?raw'
export default [

    {
        // 'MdX3Dr': 'Crosshatch',
        name: 'MdX3Dr',
        type: 'image',
        fragment,
        channels: [{ "type": "video" }]
    },
] as Config[]