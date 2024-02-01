import { Config } from '../type'
import fragment from './glsl/4dsXWn.glsl?raw'
export default [
    {
        // '4dsXWn': 'Weather',
        name: '4dsXWn',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'music' },
        ],
    },
] as Config[]
