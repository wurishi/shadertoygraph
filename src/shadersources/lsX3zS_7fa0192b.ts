import { Config } from '../type'
import fragment from './glsl/lsX3zS_7fa0192b.glsl?raw'
export default [
    {
        // 'lsX3zS': 'mod of crystal gap ',
        name: 'lsX3zS',
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
