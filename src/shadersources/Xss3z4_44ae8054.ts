import { Config } from '../type'
import fragment from './glsl/Xss3z4_44ae8054.glsl?raw'
export default [
    {
        // 'Xss3z4': 'Terrain + Sun',
        name: 'Xss3z4',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Stars',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'music' },
        ],
    },
] as Config[]
