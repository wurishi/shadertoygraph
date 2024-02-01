import { Config } from '../type'
import fragment from './glsl/4sX3z4_4cab674a.glsl?raw'
export default [
    {
        // '4sX3z4': 'Chromatic Aberration Effect',
        name: '4sX3z4',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
