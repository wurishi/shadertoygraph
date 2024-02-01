import { Config } from '../type'
import fragment from './glsl/MsXGzH.glsl?raw'
export default [
    {
        // 'MsXGzH': 'Thumper',
        name: 'MsXGzH',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
