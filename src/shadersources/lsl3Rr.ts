import { Config } from '../type'
import fragment from './glsl/lsl3Rr.glsl?raw'
export default [
    {
        // 'lsl3Rr': 'IQ Clouds with beat',
        name: 'lsl3Rr',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
