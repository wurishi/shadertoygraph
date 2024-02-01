import { Config } from '../type'
import fragment from './glsl/Xsl3zn.glsl?raw'
export default [
    {
        // 'Xsl3zn': 'Warping - texture',
        name: 'Xsl3zn',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
