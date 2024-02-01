import { Config } from '../type'
import fragment from './glsl/ldXGzS_fe989235.glsl?raw'
export default [
    {
        // 'ldXGzS': 'Area Light Equi-Angular Sampling',
        name: 'ldXGzS',
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
