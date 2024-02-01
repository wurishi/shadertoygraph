import { Config } from '../type'
import fragment from './glsl/ttlXRf.glsl?raw'
import A from './glsl/ttlXRf_A.glsl?raw'
export default [
    {
        // 'ttlXRf': 'in my crawl space',
        name: 'ttlXRf',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'music' },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
