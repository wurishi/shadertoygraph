import { Config } from '../type'
import fragment from './glsl/Mdl3z4_cd0f1f27.glsl?raw'
export default [
    {
        // 'Mdl3z4': 'box filter edge detection',
        name: 'Mdl3z4',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
