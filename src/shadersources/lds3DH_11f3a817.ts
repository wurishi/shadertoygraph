import { Config } from '../type'
import fragment from './glsl/lds3DH_11f3a817.glsl?raw'
export default [
    {
        // 'lds3DH': 'Shapeshifter',
        name: 'lds3DH',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Lichen',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
