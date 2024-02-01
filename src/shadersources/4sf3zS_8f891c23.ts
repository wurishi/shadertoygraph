import { Config } from '../type'
import fragment from './glsl/4sf3zS_8f891c23.glsl?raw'
export default [
    {
        // '4sf3zS': 'Texture twistery',
        name: '4sf3zS',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Bayer',
                filter: 'nearest',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Stars',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
