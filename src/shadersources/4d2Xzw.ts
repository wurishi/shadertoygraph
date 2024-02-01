import { Config } from '../type'
import fragment from './glsl/4d2Xzw.glsl?raw'
export default [
    {
        // '4d2Xzw': 'Bokeh disc',
        name: '4d2Xzw',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Lichen',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            {
                type: 'texture',
                src: 'Organic4',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            {
                type: 'texture',
                src: 'Stars',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
