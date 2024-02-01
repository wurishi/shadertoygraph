import { Config } from '../type'
import fragment from './glsl/MsXGDM_5b62292a.glsl?raw'
export default [
    {
        // 'MsXGDM': 'Koan',
        name: 'MsXGDM',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
