import { Config } from '../type'
import fragment from './glsl/XdsGDB.glsl?raw'
export default [
    {
        // 'XdsGDB': 'Buoy',
        name: 'XdsGDB',
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
