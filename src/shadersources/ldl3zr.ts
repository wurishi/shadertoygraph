import { Config } from '../type'
import fragment from './glsl/ldl3zr.glsl?raw'
export default [
    {
        // 'ldl3zr': 'Möbius balls',
        name: 'ldl3zr',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'cubemap',
                map: 'Forest',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Organic1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Organic2',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
