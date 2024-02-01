import { Config } from '../type'
import fragment from './glsl/4ts3z2.glsl?raw'
import Sound from './glsl/4ts3z2_sound.glsl?raw'
export default [
    {
        name: '4ts3z2',
        type: 'image',
        fragment,
        channels: [],
    },

    {
        name: 'Sound',
        type: 'sound',
        fragment: Sound,
    },
] as Config[]
