import { Config } from '../type'
import fragment from './glsl/Mdf3DN_53a77c1c.glsl?raw'
export default [
    {
        // 'Mdf3DN': 'Simple caustic',
        name: 'Mdf3DN',
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
