import { Config } from '../type'
import fragment from './glsl/ll2GD3.glsl?raw'
export default [
    {
        // 'll2GD3': 'Palettes',
        name: 'll2GD3',
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
        ],
    },
] as Config[]
