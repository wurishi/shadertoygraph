import { Config } from '../type'
import fragment from './glsl/Xl2XRW.glsl?raw'
export default [
    {
        // 'Xl2XRW': 'Where the River Goes',
        name: 'Xl2XRW',
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
        ],
    },
] as Config[]
