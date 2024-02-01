import { Config } from '../type'
import fragment from './glsl/4sSSWz.glsl?raw'
import Sound from './glsl/4sSSWz_sound.glsl?raw'
export default [
    {
        // '4sSSWz': 'starDust',
        name: '4sSSWz',
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
