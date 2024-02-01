import { Config } from '../type'
import fragment from './glsl/XsXGWM_6996fb90.glsl?raw'
export default [
    {
        // 'XsXGWM': 'plane deformation',
        name: 'XsXGWM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Lichen',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
