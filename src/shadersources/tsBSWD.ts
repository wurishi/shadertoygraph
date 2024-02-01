import { Config } from '../type'
import fragment from './glsl/tsBSWD.glsl?raw'
import A from './glsl/tsBSWD_A.glsl?raw'
export default [
    {
        // 'tsBSWD': 'Colored lines',
        name: 'tsBSWD',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [],
    },
] as Config[]
