import { Config } from '../type'
import fragment from './glsl/XsX3R7_f7c9577b.glsl?raw'
export default [
    {
        // 'XsX3R7': 'Mapping',
        name: 'XsX3R7',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'London',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'video' },
        ],
    },
] as Config[]
