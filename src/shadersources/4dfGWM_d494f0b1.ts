import { Config } from '../type'
import fragment from './glsl/4dfGWM_d494f0b1.glsl?raw'
export default [
    {
        // '4dfGWM': 'simple crosshatch',
        name: '4dfGWM',
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
