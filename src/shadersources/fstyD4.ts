import { Config } from '../type'
import fragment from './glsl/fstyD4.glsl?raw'
export default [
    {
        // 'fstyD4': 'Coastal Landscape',
        name: 'fstyD4',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
