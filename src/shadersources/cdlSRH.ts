import { Config } from '../type'
import fragment from './glsl/cdlSRH.glsl?raw'
export default [
    {
        // 'cdlSRH': 'Webcam: Water',
        name: 'cdlSRH',
        type: 'image',
        fragment,
        channels: [{ type: 'webcam', filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
