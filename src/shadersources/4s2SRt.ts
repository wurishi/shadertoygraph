import { Config } from '../type'
import fragment from './glsl/4s2SRt.glsl?raw'
export default [
    {
        // '4s2SRt': 'Oblivion radar',
        name: '4s2SRt',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
