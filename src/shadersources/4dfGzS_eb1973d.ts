import { Config } from '../type'
import fragment from './glsl/4dfGzS_eb1973d.glsl?raw'
export default [
    {
        // '4dfGzS': 'Nullpunktsenergie',
        name: '4dfGzS',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Stars',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'GrayNoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
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
