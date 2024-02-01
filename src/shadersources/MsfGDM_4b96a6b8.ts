import { Config } from '../type'
import fragment from './glsl/MsfGDM_4b96a6b8.glsl?raw'
export default [
    {
        // 'MsfGDM': 'light glow test',
        name: 'MsfGDM',
        type: 'image',
        fragment,
        channels: [{ type: 'Empty' }, { type: 'music' }],
    },
] as Config[]
