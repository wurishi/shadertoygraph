import { Config } from '../type'
import fragment from './glsl/lss3zn.glsl?raw'
export default [
    {
        // 'lss3zn': 'Multiple Effects',
        name: 'lss3zn',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
