import { Config } from '../type'
import fragment from './glsl/XsfGzH.glsl?raw'
export default [
    {
        // 'XsfGzH': 'Star Nursery',
        name: 'XsfGzH',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'linear',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'music' },
            { type: 'volume', volume: 'GreyNoise3D' },
        ],
    },
] as Config[]
