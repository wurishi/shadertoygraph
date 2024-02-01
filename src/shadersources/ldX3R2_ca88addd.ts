import { Config } from '../type'
import fragment from './glsl/ldX3R2_ca88addd.glsl?raw'
export default [
    {
        // 'ldX3R2': 'Worley noise',
        name: 'ldX3R2',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'webcam', filter: 'linear', wrap: 'clamp' },
        ],
    },
] as Config[]
