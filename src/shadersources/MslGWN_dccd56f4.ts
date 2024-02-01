import { Config } from '../type'
import fragment from './glsl/MslGWN_dccd56f4.glsl?raw'
export default [
    {
        // 'MslGWN': 'Simplicity Galaxy',
        name: 'MslGWN',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
