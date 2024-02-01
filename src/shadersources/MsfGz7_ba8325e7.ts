import { Config } from '../type'
import fragment from './glsl/MsfGz7_ba8325e7.glsl?raw'
export default [
    {
        // 'MsfGz7': 'Shatter',
        name: 'MsfGz7',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'cubemap',
                map: 'Forest',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
        ],
    },
] as Config[]
