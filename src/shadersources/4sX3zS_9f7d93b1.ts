import { Config } from '../type'
import fragment from './glsl/4sX3zS_9f7d93b1.glsl?raw'
export default [
    {
        // '4sX3zS': 'Haunted forest 2',
        name: '4sX3zS',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'GrayNoiseMedium',
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
