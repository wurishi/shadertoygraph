import { Config } from '../type'
import fragment from './glsl/4sjSW1.glsl?raw'
import Sound from './glsl/4sjSW1_sound.glsl?raw'
export default [
    {
        // '4sjSW1': 'Remnant X',
        name: '4sjSW1',
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

    {
        name: 'Sound',
        type: 'sound',
        fragment: Sound,
    },
] as Config[]
