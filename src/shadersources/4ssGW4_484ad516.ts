import { Config } from '../type'
import fragment from './glsl/4ssGW4_484ad516.glsl?raw'
export default [
    {
        // '4ssGW4': 'Blah',
        name: '4ssGW4',
        type: 'image',
        fragment,
        channels: [
            { type: 'video' },
            {
                type: 'texture',
                src: 'RGBANoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
