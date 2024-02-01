import { Config } from '../type'
import fragment from './glsl/Mss3Dr_c9cfeca4.glsl?raw'
export default [
    {
        // 'Mss3Dr': 'AudioSurf',
        name: 'Mss3Dr',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
