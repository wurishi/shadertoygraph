import { Config } from '../type'
import fragment from './glsl/MsVfz1.glsl?raw'
export default [
    {
        // 'MsVfz1': 'Neon Lit Hexagons',
        name: 'MsVfz1',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RustyMetal',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
