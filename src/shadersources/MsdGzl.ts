import { Config } from '../type'
import fragment from './glsl/MsdGzl.glsl?raw'
import A from './glsl/MsdGzl_A.glsl?raw'
export default [
    {
        // 'MsdGzl': 'Basic Montecarlo',
        name: 'MsdGzl',
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
