import { Config } from '../type'
import fragment from './glsl/4dl3D4_a0e75853.glsl?raw'
export default [
    {
        // '4dl3D4': 'Gravel',
        name: '4dl3D4',
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
            {
                type: 'texture',
                src: 'Bayer',
                filter: 'nearest',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
