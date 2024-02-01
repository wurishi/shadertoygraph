import { Config } from '../type'
import fragment from './glsl/MsSGD1.glsl?raw'
export default [
    {
        // 'MsSGD1': 'Hand-drawn Sketch',
        name: 'MsSGD1',
        type: 'image',
        fragment,
        channels: [
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
