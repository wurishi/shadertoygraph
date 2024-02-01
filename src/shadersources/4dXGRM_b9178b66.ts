import { Config } from '../type'
import fragment from './glsl/4dXGRM_b9178b66.glsl?raw'
export default [
    {
        // '4dXGRM': 'flying steel cubes',
        name: '4dXGRM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RustyMetal',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
