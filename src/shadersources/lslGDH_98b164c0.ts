import { Config } from '../type'
import fragment from './glsl/lslGDH_98b164c0.glsl?raw'
export default [
    {
        // 'lslGDH': 'Bump to normal',
        name: 'lslGDH',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'GrayNoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
