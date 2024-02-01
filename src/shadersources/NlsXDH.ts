import { Config } from '../type'
import fragment from './glsl/NlsXDH.glsl?raw'
export default [
    {
        // 'NlsXDH': 'Exit the Matrix',
        name: 'NlsXDH',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
