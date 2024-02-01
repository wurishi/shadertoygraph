import { Config } from '../type'
import fragment from './glsl/XtdGR7.glsl?raw'
export default [
    {
        // 'XtdGR7': '[SH16B] WIP: Warp Tunnel',
        name: 'XtdGR7',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'texture', src: 'Stars', filter: 'mipmap', wrap: 'repeat' },
            {
                type: 'texture',
                src: 'Organic2',
                filter: 'linear',
                wrap: 'repeat',
            },
            { type: 'music' },
        ],
    },
] as Config[]
