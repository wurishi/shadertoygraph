import { Config } from '../type'
import fragment from './glsl/ldl3WM_80c5ac3.glsl?raw'
export default [
    {
        // 'ldl3WM': 'cartoon video - test',
        name: 'ldl3WM',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
