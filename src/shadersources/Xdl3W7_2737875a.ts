import { Config } from '../type'
import fragment from './glsl/Xdl3W7_2737875a.glsl?raw'
export default [
    {
        // 'Xdl3W7': 'Lakes and mountains',
        name: 'Xdl3W7',
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
