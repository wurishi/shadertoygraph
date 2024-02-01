import { Config } from '../type'
import fragment from './glsl/XdXGR7_76f1dc65.glsl?raw'
export default [
    {
        // 'XdXGR7': 'water drops',
        name: 'XdXGR7',
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
