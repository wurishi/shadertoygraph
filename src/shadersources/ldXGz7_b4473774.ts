import { Config } from '../type'
import fragment from './glsl/ldXGz7_b4473774.glsl?raw'
export default [
    {
        // 'ldXGz7': '2d water shader',
        name: 'ldXGz7',
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
