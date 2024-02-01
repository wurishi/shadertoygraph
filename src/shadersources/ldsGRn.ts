import { Config } from '../type'
import fragment from './glsl/ldsGRn.glsl?raw'
export default [
    {
        // 'ldsGRn': 'my first shader',
        name: 'ldsGRn',
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
