import { Config } from '../type'
import fragment from './glsl/MddGzf.glsl?raw'
import A from './glsl/MddGzf_A.glsl?raw'
export default [
    {
        // 'MddGzf': 'Bricks Game',
        name: 'MddGzf',
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
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'keyboard' },
        ],
    },
] as Config[]
