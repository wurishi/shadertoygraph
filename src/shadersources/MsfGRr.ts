import { Config } from '../type'
import fragment from './glsl/MsfGRr.glsl?raw'
export default [
    {
        // 'MsfGRr': 'Julia - Quaternion 1',
        name: 'MsfGRr',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
