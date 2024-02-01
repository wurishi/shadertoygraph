import { Config } from '../type'
import fragment from './glsl/MssGRB_a076a953.glsl?raw'
export default [
    {
        // 'MssGRB': 'webcam roberts',
        name: 'MssGRB',
        type: 'image',
        fragment,
        channels: [{ type: 'webcam', filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
