import { Config } from '../type'
import fragment from './glsl/4ssGR8.glsl?raw'
export default [
    {
        // '4ssGR8': 'Soft Threshold Filter',
        name: '4ssGR8',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
