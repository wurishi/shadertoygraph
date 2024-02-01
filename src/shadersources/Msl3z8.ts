import { Config } from '../type'
import fragment from './glsl/Msl3z8.glsl?raw'
export default [
    {
        // 'Msl3z8': 'Blurred ball',
        name: 'Msl3z8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
