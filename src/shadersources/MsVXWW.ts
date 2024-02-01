import { Config } from '../type'
import fragment from './glsl/MsVXWW.glsl?raw'
export default [
    {
        // 'MsVXWW': 'Dusty nebula 4',
        name: 'MsVXWW',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'linear',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'keyboard' },
        ],
    },
] as Config[]
