import { Config } from '../type'
import fragment from './glsl/lss3R7_1f113aff.glsl?raw'
export default [
    {
        // 'lss3R7': 'Alhambra on lsd (sound)',
        name: 'lss3R7',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
