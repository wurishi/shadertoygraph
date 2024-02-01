import { Config } from '../type'
import fragment from './glsl/Mdf3Dn_68c95cd4.glsl?raw'
export default [

    {
        // 'Mdf3Dn': 'CMYK Halftone',
        name: 'Mdf3Dn',
        type: 'image',
        fragment,
        channels: [{ "type": "video" }]
    },
] as Config[]