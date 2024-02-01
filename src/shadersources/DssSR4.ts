import { Config } from '../type'
import fragment from './glsl/DssSR4.glsl?raw'
export default [
    {
        // 'DssSR4': 'circle Animation',
        name: 'DssSR4',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
