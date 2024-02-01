import { Config } from '../type'

import Image from './glsl/XsBXWt.glsl?raw'
import Sound from './glsl/XsBXWt_s.glsl?raw'

export default [
    {
        name: 'XsBXWt',
        type: 'image',
        fragment: Image,
        channels: [
            {
                type: 'music',
            },
            {
                type: 'texture',
                src: 'Nyancat',
                filter: 'nearest',
                wrap: 'clamp',
                noFlip: true,
            },
        ],
    },
    {
        name: 'Sound',
        type: 'sound',
        fragment: Sound,
    },
] as Config[]
