import { Config } from '../type'
import fragment from './glsl/MdX3zS_6190842a.glsl?raw'
export default [
    {
        // 'MdX3zS': 'exponential ? ',
        name: 'MdX3zS',
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
        ],
    },
] as Config[]
