import { Config } from '../type'
import fragment from './glsl/XsXGD8_28163fb1.glsl?raw'
export default [
    {
        // 'XsXGD8': 'Sorry, I went abstract',
        name: 'XsXGD8',
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
