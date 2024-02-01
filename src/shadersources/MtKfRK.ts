import { Config } from '../type'
import fragment from './glsl/MtKfRK.glsl?raw'
export default [
    {
        // 'MtKfRK': 'Data stream',
        name: 'MtKfRK',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
