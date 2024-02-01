import { Config } from '../type'
import fragment from './glsl/Xdl3R8.glsl?raw'
export default [
    {
        // 'Xdl3R8': 'UV Map Filter',
        name: 'Xdl3R8',
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
            { type: 'video' },
        ],
    },
] as Config[]
