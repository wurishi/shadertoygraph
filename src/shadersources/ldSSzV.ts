import { Config } from '../type'
import fragment from './glsl/ldSSzV.glsl?raw'
export default [
    {
        // 'ldSSzV': 'Wet stone',
        name: 'ldSSzV',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
