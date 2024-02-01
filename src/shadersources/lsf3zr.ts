import { Config } from '../type'
import fragment from './glsl/lsf3zr.glsl?raw'
export default [
    {
        // 'lsf3zr': 'Columns and Lights',
        name: 'lsf3zr',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Stars',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Organic3',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
