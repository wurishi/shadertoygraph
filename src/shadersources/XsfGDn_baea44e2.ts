import { Config } from '../type'
import fragment from './glsl/XsfGDn_baea44e2.glsl?raw'
export default [
    {
        // 'XsfGDn': 'Texture - Better Filtering',
        name: 'XsfGDn',
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
