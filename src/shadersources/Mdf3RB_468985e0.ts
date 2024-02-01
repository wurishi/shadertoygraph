import { Config } from '../type'
import fragment from './glsl/Mdf3RB_468985e0.glsl?raw'
export default [
    {
        // 'Mdf3RB': 'wormhole moment hack ',
        name: 'Mdf3RB',
        type: 'image',
        fragment,
        channels: [
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
