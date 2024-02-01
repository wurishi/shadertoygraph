import { Config } from '../type'
import fragment from './glsl/MslGD8_444c36f.glsl?raw'
export default [
    {
        // 'MslGD8': 'Voronoi - basic',
        name: 'MslGD8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
