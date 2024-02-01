import { Config } from '../type'
import fragment from './glsl/Xsc3R4.glsl?raw'
export default [
    {
        // 'Xsc3R4': 'Cheap Cloud Flythrough',
        name: 'Xsc3R4',
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
