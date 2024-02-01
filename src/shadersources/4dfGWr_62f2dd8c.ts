import { Config } from '../type'
import fragment from './glsl/4dfGWr_62f2dd8c.glsl?raw'
export default [
    {
        // '4dfGWr': 'Kaleidoscope tre - bendy',
        name: '4dfGWr',
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
