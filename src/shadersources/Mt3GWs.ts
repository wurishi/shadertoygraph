import { Config } from '../type'
import fragment from './glsl/Mt3GWs.glsl?raw'
export default [
    {
        // 'Mt3GWs': 'Structured Vol Sampling',
        name: 'Mt3GWs',
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
