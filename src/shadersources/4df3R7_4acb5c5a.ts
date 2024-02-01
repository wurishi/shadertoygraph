import { Config } from '../type'
import fragment from './glsl/4df3R7_4acb5c5a.glsl?raw'
export default [
    {
        // '4df3R7': 'Circular Blur',
        name: '4df3R7',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'London',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Bayer',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'BlueNoise',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
