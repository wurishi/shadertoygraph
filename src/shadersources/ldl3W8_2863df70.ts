import { Config } from '../type'
import fragment from './glsl/ldl3W8_2863df70.glsl?raw'
export default [
    {
        // 'ldl3W8': 'Voronoi - distances',
        name: 'ldl3W8',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'nearest',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
