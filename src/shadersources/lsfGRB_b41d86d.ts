import { Config } from '../type'
import fragment from './glsl/lsfGRB_b41d86d.glsl?raw'
export default [
    {
        // 'lsfGRB': 'Lame Raytraced Spheres',
        name: 'lsfGRB',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'GrayNoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
