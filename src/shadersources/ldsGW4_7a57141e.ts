import { Config } from '../type'
import fragment from './glsl/ldsGW4_7a57141e.glsl?raw'
export default [
    {
        // 'ldsGW4': 'Psychedelic Ghost Britney',
        name: 'ldsGW4',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
