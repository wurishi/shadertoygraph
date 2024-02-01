import { Config } from '../type'
import fragment from './glsl/lslGW8_a95b546e.glsl?raw'
export default [
    {
        // 'lslGW8': 'Bump mapping',
        name: 'lslGW8',
        type: 'image',
        fragment,
        channels: [
            { type: 'video' },
            {
                type: 'texture',
                src: 'Abstract2',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
