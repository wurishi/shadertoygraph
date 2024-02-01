import { Config } from '../type'
import fragment from './glsl/lslGDn_4abce13d.glsl?raw'
export default [
    {
        // 'lslGDn': 'Shadertoy',
        name: 'lslGDn',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Wood',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
