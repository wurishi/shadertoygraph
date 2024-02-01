import { Config } from '../type'
import fragment from './glsl/4sX3Rs.glsl?raw'
export default [
    {
        // '4sX3Rs': 'Lens Flare Example',
        name: '4sX3Rs',
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
