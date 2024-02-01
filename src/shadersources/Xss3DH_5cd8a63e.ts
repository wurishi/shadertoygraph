import { Config } from '../type'
import fragment from './glsl/Xss3DH_5cd8a63e.glsl?raw'
export default [
    {
        // 'Xss3DH': 'Candlestick',
        name: 'Xss3DH',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'cubemap',
                map: 'Basilica',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
            {
                type: 'cubemap',
                map: 'BasilicaBlur',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Wood',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
