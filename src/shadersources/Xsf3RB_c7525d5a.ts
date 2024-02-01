import { Config } from '../type'
import fragment from './glsl/Xsf3RB_c7525d5a.glsl?raw'
export default [
    {
        // 'Xsf3RB': 'Submerged',
        name: 'Xsf3RB',
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
