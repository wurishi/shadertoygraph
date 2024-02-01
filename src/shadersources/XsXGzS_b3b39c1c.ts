import { Config } from '../type'
import fragment from './glsl/XsXGzS_b3b39c1c.glsl?raw'
export default [
    {
        // 'XsXGzS': 'hanShader',
        name: 'XsXGzS',
        type: 'image',
        fragment,
        channels: [
            { type: 'music' },
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
