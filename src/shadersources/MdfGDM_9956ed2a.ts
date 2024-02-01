import { Config } from '../type'
import fragment from './glsl/MdfGDM_9956ed2a.glsl?raw'
export default [
    {
        // 'MdfGDM': 'Raytracer Many Spheres',
        name: 'MdfGDM',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
