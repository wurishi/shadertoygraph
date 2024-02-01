import { Config } from '../type'
import fragment from './glsl/XlsGRs.glsl?raw'
export default [
    {
        // 'XlsGRs': 'jetstream',
        name: 'XlsGRs',
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
        ],
    },
] as Config[]
