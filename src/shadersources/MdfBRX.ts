import { Config } from '../type'

import Image from './glsl/MdfBRX.glsl?raw'

export default [
    {
        name: 'MdfBRX',
        type: 'image',
        fragment: Image,
        channels: [
            {
                type: 'music',
                // TODO: pause music
            },
        ],
    },
] as Config[]
