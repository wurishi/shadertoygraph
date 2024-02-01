import { Config } from '../type'
import fragment from './glsl/4sf3Dn_96244b4f.glsl?raw'
export default [
    {
        // '4sf3Dn': 'Brain Storm',
        name: '4sf3Dn',
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
