import { Config } from '../type'
import fragment from './glsl/XsXGD4_21a0739a.glsl?raw'
export default [
    {
        // 'XsXGD4': 'Under the floor',
        name: 'XsXGD4',
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
