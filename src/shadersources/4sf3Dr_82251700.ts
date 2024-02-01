import { Config } from '../type'
import fragment from './glsl/4sf3Dr_82251700.glsl?raw'
export default [
    {
        // '4sf3Dr': 'CRT Effect',
        name: '4sf3Dr',
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
