import { Config } from '../type'
import fragment from './glsl/4tlSzl.glsl?raw'
export default [
    {
        // '4tlSzl': 'Combustible Voronoi',
        name: '4tlSzl',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
