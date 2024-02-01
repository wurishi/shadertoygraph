import { Config } from '../type'
import fragment from './glsl/lsl3zn.glsl?raw'
export default [
    {
        // 'lsl3zn': 'BlobBox',
        name: 'lsl3zn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
