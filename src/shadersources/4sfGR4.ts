import { Config } from '../type'
import fragment from './glsl/4sfGR4.glsl?raw'
export default [
    {
        // '4sfGR4': 'mod filter',
        name: '4sfGR4',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
