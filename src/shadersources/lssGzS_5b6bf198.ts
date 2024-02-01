import { Config } from '../type'
import fragment from './glsl/lssGzS_5b6bf198.glsl?raw'
export default [
    {
        // 'lssGzS': 'Stunnel',
        name: 'lssGzS',
        type: 'image',
        fragment,
        channels: [
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
