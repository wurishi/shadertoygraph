import { Config } from '../type'
import fragment from './glsl/tt2XzG.glsl?raw'
import Sound from './glsl/tt2XzG_sound.glsl?raw'
export default [
    {
        // 'tt2XzG': 'Sphere Gears',
        name: 'tt2XzG',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RustyMetal',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },

    {
        name: 'Sound',
        type: 'sound',
        fragment: Sound,
    },
] as Config[]
