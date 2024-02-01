import { Config } from '../type'
import fragment from './glsl/ldl3DN_f0ea4aeb.glsl?raw'
export default [
    {
        // 'ldl3DN': 'Run in the night',
        name: 'ldl3DN',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RustyMetal',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
