import { Config } from '../type'
import fragment from './glsl/4ssGzH.glsl?raw'
export default [
    {
        // '4ssGzH': 'Hysto',
        name: '4ssGzH',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
