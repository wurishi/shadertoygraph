import { Config } from '../type'
import fragment from './glsl/lds3RH.glsl?raw'
export default [
    {
        // 'lds3RH': 'FakeRipple',
        name: 'lds3RH',
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
