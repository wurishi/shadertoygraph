import { Config } from '../type'
import fragment from './glsl/Xsl3DM_24c81578.glsl?raw'
export default [
    {
        // 'Xsl3DM': 'Nova Fractal',
        name: 'Xsl3DM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
