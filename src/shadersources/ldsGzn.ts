import { Config } from '../type'
import fragment from './glsl/ldsGzn.glsl?raw'
export default [
    {
        // 'ldsGzn': 'Cube bird',
        name: 'ldsGzn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
