import { Config } from '../type'
import fragment from './glsl/lsX3D7_74baa717.glsl?raw'
export default [
    {
        // 'lsX3D7': 'MandelNyanCatBrot',
        name: 'lsX3D7',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Nyancat',
                filter: 'nearest',
                wrap: 'clamp',
                noFlip: true,
            },
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
