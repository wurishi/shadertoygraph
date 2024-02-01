import { Config } from '../type'
import fragment from './glsl/ldd3DB.glsl?raw'
import A from './glsl/ldd3DB_A.glsl?raw'
import Common from './glsl/ldd3DB_common.glsl?raw'
export default [
    {
        // 'ldd3DB': 'Interactive Shoal of fish',
        name: 'ldd3DB',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [{ type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' }],
    },

    {
        name: 'Common',
        type: 'common',
        fragment: Common,
    },
] as Config[]
