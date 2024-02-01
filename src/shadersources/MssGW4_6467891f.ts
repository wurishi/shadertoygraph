import { Config } from '../type'
import fragment from './glsl/MssGW4_6467891f.glsl?raw'
export default [
    {
        // 'MssGW4': 'Iterations - guts',
        name: 'MssGW4',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Organic2',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
