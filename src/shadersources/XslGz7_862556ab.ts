import { Config } from '../type'
import fragment from './glsl/XslGz7_862556ab.glsl?raw'
export default [
    {
        // 'XslGz7': 'Kaleidoscope Ett',
        name: 'XslGz7',
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
