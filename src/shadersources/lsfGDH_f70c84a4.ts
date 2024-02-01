import { Config } from '../type'
import fragment from './glsl/lsfGDH_f70c84a4.glsl?raw'
export default [
    {
        // 'lsfGDH': 'roto wobble',
        name: 'lsfGDH',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Bayer',
                filter: 'nearest',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
