import { Config } from '../type'
import fragment from './glsl/lsl3Rn.glsl?raw'
import Sound from './glsl/lsl3Rn_sound.glsl?raw'
export default [
    {
        // 'lsl3Rn': 'R Tape loading error, 0:1',
        name: 'lsl3Rn',
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
