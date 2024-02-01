import { Config } from '../type'
import fragment from './glsl/ldfGR2_8984e2c3.glsl?raw'
export default [
    {
        // 'ldfGR2': 'scanline',
        name: 'ldfGR2',
        type: 'image',
        fragment,
        channels: [
            { type: 'video' },
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
