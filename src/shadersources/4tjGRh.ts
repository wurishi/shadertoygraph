import { Config } from '../type'
import fragment from './glsl/4tjGRh.glsl?raw'
import Sound from './glsl/4tjGRh_sound.glsl?raw'
export default [
    {
        // '4tjGRh': 'Planet Shadertoy',
        name: '4tjGRh',
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
