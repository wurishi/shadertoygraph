import { Config } from '../type'
import fragment from './glsl/4sfGRB_eb9c52f7.glsl?raw'
export default [
    {
        // '4sfGRB': 'Night sky',
        name: '4sfGRB',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'GrayNoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
