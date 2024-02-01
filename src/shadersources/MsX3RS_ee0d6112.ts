import { Config } from '../type'
import fragment from './glsl/MsX3RS_ee0d6112.glsl?raw'
export default [
    {
        // 'MsX3RS': 'britney composite',
        name: 'MsX3RS',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }, { type: 'video' }],
    },
] as Config[]
