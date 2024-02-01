import { Config } from '../type'
import fragment from './glsl/slKfDt.glsl?raw'
export default [
    {
        // 'slKfDt': 'Standard Operators (xy grids)',
        name: 'slKfDt',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
