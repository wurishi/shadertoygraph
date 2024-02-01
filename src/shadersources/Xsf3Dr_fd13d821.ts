import { Config } from '../type'
import fragment from './glsl/Xsf3Dr_fd13d821.glsl?raw'
export default [
    {
        // 'Xsf3Dr': 'Texture - HW interpolation',
        name: 'Xsf3Dr',
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
        ],
    },
] as Config[]
