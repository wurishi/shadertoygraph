import { Config } from '../type'
import fragment from './glsl/4dsXzM.glsl?raw'
export default [
    {
        // '4dsXzM': 'Fovea detector',
        name: '4dsXzM',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
