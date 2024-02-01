import { Config } from '../type'
import fragment from './glsl/XsjXRm.glsl?raw'

export default [
    {
        name: 'XsjXRm', //
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
            },
        ],
    },
] as Config[]
