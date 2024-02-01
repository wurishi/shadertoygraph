import { Config } from '../type'
import fragment from './glsl/4sfGR7_cbf3d744.glsl?raw'
export default [
    {
        // '4sfGR7': 'Abandoned base on Mars',
        name: '4sfGR7',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Organic1',
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
        ],
    },
] as Config[]
