import { Config } from '../type'
import fragment from './glsl/XdsGR7_1c2f45a.glsl?raw'
export default [
    {
        // 'XdsGR7': 'Colors2',
        name: 'XdsGR7',
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
        ],
    },
] as Config[]
