import { Config } from '../type'
import fragment from './glsl/4dX3WN_e91ee15.glsl?raw'
export default [
    {
        // '4dX3WN': 'Chroma key',
        name: '4dX3WN',
        type: 'image',
        fragment,
        channels: [
            { type: 'video' },
            {
                type: 'texture',
                src: 'London',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
