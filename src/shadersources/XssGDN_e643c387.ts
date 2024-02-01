import { Config } from '../type'
import fragment from './glsl/XssGDN_e643c387.glsl?raw'
export default [
    {
        // 'XssGDN': 'shroom test',
        name: 'XssGDN',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'London',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
