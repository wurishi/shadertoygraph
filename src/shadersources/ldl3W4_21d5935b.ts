import { Config } from '../type'
import fragment from './glsl/ldl3W4_21d5935b.glsl?raw'
export default [
    {
        // 'ldl3W4': 'Iterations - worms',
        name: 'ldl3W4',
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
