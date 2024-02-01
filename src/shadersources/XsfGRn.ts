import { Config } from '../type'
import fragment from './glsl/XsfGRn.glsl?raw'
export default [
    {
        // 'XsfGRn': 'Heart - 2D',
        name: 'XsfGRn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
