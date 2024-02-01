import { Config } from '../type'
import fragment from './glsl/fslcDS.glsl?raw'
export default [
    {
        // 'fslcDS': 'Trippy Triangle',
        name: 'fslcDS',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
