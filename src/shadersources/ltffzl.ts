import { Config } from '../type'

import Image from './glsl/ltffzl.glsl?raw'

export default [
    {
        name: 'ltffzl',
        type: 'image',
        fragment: Image,
        channels: [
            {
                type: 'texture',
                src: 'London',
            },
        ],
    },
] as Config[]
