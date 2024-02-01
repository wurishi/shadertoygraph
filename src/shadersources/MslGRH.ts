import { Config } from '../type'
import fragment from './glsl/MslGRH.glsl?raw'
export default [
    {
        // 'MslGRH': 'Binary Serpents',
        name: 'MslGRH',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
