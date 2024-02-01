import { Config } from '../type'
import fragment from './glsl/MssGDM_2c510115.glsl?raw'
export default [
    {
        // 'MssGDM': 'A night on the Town',
        name: 'MssGDM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'London',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
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
