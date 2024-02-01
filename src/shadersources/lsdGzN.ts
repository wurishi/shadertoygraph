import { Config } from '../type'
import fragment from './glsl/lsdGzN.glsl?raw'
export default [
    {
        // 'lsdGzN': 'Will it blend',
        name: 'lsdGzN',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
