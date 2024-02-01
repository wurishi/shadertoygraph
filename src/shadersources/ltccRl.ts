import { Config } from '../type'
import fragment from './glsl/ltccRl.glsl?raw'
import A from './glsl/ltccRl_A.glsl?raw'
export default [
    {
        // 'ltccRl': 'Outrun The Rain',
        name: 'ltccRl',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
