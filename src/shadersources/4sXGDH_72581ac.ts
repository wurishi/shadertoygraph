import { Config } from '../type'
import fragment from './glsl/4sXGDH_72581ac.glsl?raw'
export default [
    {
        // '4sXGDH': 'Lemminvade',
        name: '4sXGDH',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Organic2',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'music' },
        ],
    },
] as Config[]
