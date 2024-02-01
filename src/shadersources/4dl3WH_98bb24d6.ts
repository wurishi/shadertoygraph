import { Config } from '../type'
import fragment from './glsl/4dl3WH_98bb24d6.glsl?raw'
export default [
    {
        // '4dl3WH': 'Little PathTracing',
        name: '4dl3WH',
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
            { type: 'music' },
        ],
    },
] as Config[]
