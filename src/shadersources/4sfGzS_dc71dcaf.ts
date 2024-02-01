import { Config } from '../type'
import fragment from './glsl/4sfGzS_dc71dcaf.glsl?raw'
export default [
    {
        // '4sfGzS': 'Noise - value - 3D',
        name: '4sfGzS',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'linear',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
