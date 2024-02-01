import { Config } from '../type'
import fragment from './glsl/4dX3Wn_35ffcedd.glsl?raw'
export default [
    {
        // '4dX3Wn': 'Tunnel of doom',
        name: '4dX3Wn',
        type: 'image',
        fragment,
        channels: [
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
