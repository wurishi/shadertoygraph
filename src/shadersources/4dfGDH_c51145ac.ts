import { Config } from '../type'
import fragment from './glsl/4dfGDH_c51145ac.glsl?raw'
export default [
    {
        // '4dfGDH': 'Bilateral filter',
        name: '4dfGDH',
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
