import { Config } from '../type'
import fragment from './glsl/4dfXDn.glsl?raw'
export default [
    {
        // '4dfXDn': '2d signed distance functions',
        name: '4dfXDn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
