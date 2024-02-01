import { Config } from '../type'
import fragment from './glsl/4dX3z2_770889ed.glsl?raw'
export default [
    {
        // '4dX3z2': 'Distort Close',
        name: '4dX3z2',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Lichen',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
