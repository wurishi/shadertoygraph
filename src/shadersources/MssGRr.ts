import { Config } from '../type'
import fragment from './glsl/MssGRr.glsl?raw'
export default [
    {
        // 'MssGRr': 'Playing around',
        name: 'MssGRr',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
