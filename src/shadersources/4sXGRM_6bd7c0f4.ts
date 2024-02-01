import { Config } from '../type'
import fragment from './glsl/4sXGRM_6bd7c0f4.glsl?raw'
export default [
    {
        // '4sXGRM': 'Oceanic',
        name: '4sXGRM',
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
