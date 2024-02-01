import { Config } from '../type'
import fragment from './glsl/MlXSWX.glsl?raw'
export default [
    {
        // 'MlXSWX': 'Abstract Corridor',
        name: 'MlXSWX',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Abstract2',
                filter: 'mipmap',
                wrap: 'repeat',
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
