import { Config } from '../type'
import fragment from './glsl/Mds3D8_8d060fb8.glsl?raw'
export default [
    {
        // 'Mds3D8': 'Curiosity',
        name: 'Mds3D8',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RustyMetal',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
