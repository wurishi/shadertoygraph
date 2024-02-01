import { Config } from '../type'
import fragment from './glsl/Xsl3DH_54a2e1f7.glsl?raw'
export default [
    {
        // 'Xsl3DH': 'Shockwaves',
        name: 'Xsl3DH',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RockTiles',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
