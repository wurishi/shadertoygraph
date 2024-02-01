import { Config } from '../type'
import fragment from './glsl/ldXGD7_f5822c09.glsl?raw'
export default [
    {
        // 'ldXGD7': 'Smokey spiral',
        name: 'ldXGD7',
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
                src: 'GrayNoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
