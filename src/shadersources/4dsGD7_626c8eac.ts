import { Config } from '../type'
import fragment from './glsl/4dsGD7_626c8eac.glsl?raw'
import Sound from './glsl/4dsGD7_626c8eac_sound.glsl?raw'
export default [
    {
        // '4dsGD7': 'The Inversion Machine',
        name: '4dsGD7',
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
