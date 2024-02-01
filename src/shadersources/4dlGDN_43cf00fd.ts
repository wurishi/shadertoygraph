import { Config } from '../type'
import fragment from './glsl/4dlGDN_43cf00fd.glsl?raw'
export default [
    {
        // '4dlGDN': 'Noise blur',
        name: '4dlGDN',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Organic1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
