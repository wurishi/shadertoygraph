import { Config } from '../type'
import fragment from './glsl/MdfGW8_d8d6290b.glsl?raw'
export default [
    {
        // 'MdfGW8': 'wat tracing',
        name: 'MdfGW8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
