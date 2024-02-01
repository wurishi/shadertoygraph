import { Config } from '../type'
import fragment from './glsl/WtSfWK.glsl?raw'
export default [
    {
        // 'WtSfWK': 'Hexagonal Grid Traversal - 3D',
        name: 'WtSfWK',
        type: 'image',
        fragment,
        channels: [
            { type: 'texture', src: 'Wood', filter: 'mipmap', wrap: 'repeat' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
