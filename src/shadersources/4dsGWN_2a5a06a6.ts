import { Config } from '../type'
import fragment from './glsl/4dsGWN_2a5a06a6.glsl?raw'
export default [
    {
        // '4dsGWN': 'Polaresian',
        name: '4dsGWN',
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
