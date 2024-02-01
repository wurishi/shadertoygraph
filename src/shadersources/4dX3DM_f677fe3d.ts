import { Config } from '../type'
import fragment from './glsl/4dX3DM_f677fe3d.glsl?raw'
export default [
    {
        // '4dX3DM': 'RGB display',
        name: '4dX3DM',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
