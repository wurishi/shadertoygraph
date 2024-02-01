import { Config } from '../type'
import fragment from './glsl/WdB3Dw.glsl?raw'
export default [
    {
        // 'WdB3Dw': 'Bubble rings',
        name: 'WdB3Dw',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
