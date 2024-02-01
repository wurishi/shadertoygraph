import { Config } from '../type'
import fragment from './glsl/ltj3zR.glsl?raw'
import Sound from './glsl/ltj3zR_sound.glsl?raw'
export default [
    {
        // 'ltj3zR': '[NV15] Impact',
        name: 'ltj3zR',
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
