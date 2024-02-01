import { Config } from '../type'
import fragment from './glsl/lslXRS.glsl?raw'
export default [
    {
        // 'lslXRS': 'Noise animation - Lava',
        name: 'lslXRS',
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
