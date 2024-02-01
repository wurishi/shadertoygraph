import { Config } from '../type'
import fragment from './glsl/3sySRK.glsl?raw'
export default [
    {
        // '3sySRK': 'CineShader Lava',
        name: '3sySRK',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
