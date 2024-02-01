import { Config } from '../type'
import fragment from './glsl/MsXGR8.glsl?raw'
export default [
    {
        // 'MsXGR8': 'Split Prism',
        name: 'MsXGR8',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'London',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
