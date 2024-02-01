import { Config } from '../type'
import fragment from './glsl/XdfGDH_ba278a8d.glsl?raw'
export default [
    {
        // 'XdfGDH': 'Gaussian Blur',
        name: 'XdfGDH',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
