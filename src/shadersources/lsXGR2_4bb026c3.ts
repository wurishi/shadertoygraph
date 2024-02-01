import { Config } from '../type'
import fragment from './glsl/lsXGR2_4bb026c3.glsl?raw'
export default [
    {
        // 'lsXGR2': 'Ground Test',
        name: 'lsXGR2',
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
            { type: 'music' },
        ],
    },
] as Config[]
