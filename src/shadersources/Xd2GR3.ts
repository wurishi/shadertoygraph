import { Config } from '../type'
import fragment from './glsl/Xd2GR3.glsl?raw'
export default [
    {
        // 'Xd2GR3': 'Hexagons - distance',
        name: 'Xd2GR3',
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
