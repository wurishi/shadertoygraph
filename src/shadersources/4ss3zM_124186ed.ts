import { Config } from '../type'
import fragment from './glsl/4ss3zM_124186ed.glsl?raw'
export default [
    {
        // '4ss3zM': 'Trial2',
        name: '4ss3zM',
        type: 'image',
        fragment,
        channels: [
            { type: 'Empty' },
            {
                type: 'texture',
                src: 'RGBANoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Bayer',
                filter: 'nearest',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
