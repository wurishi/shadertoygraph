import { Config } from '../type'
import fragment from './glsl/4dXGD7_155fa693.glsl?raw'
export default [
    {
        // '4dXGD7': 'reuleaux saturn with eyes',
        name: '4dXGD7',
        type: 'image',
        fragment,
        channels: [
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
