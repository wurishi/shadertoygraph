import { Config } from '../type'
import fragment from './glsl/4sfGWr_b032961e.glsl?raw'
export default [
    {
        // '4sfGWr': 'Voronoitoy',
        name: '4sfGWr',
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
