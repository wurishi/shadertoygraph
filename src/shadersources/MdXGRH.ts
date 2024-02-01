import { Config } from '../type'
import fragment from './glsl/MdXGRH.glsl?raw'
export default [
    {
        // 'MdXGRH': 'Twisted!',
        name: 'MdXGRH',
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
