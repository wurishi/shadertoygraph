import { Config } from '../type'
import fragment from './glsl/4sl3DH_2b942ed6.glsl?raw'
export default [
    {
        // '4sl3DH': 'Simple Hue Rotation',
        name: '4sl3DH',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
