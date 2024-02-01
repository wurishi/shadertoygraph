import { Config } from '../type'
import fragment from './glsl/NddSWs.glsl?raw'
import Common from './glsl/NddSWs_common.glsl?raw'
import A from './glsl/NddSWs_A.glsl?raw'
export default [
    {
        // 'NddSWs': 'Taste of Noise 7',
        name: 'NddSWs',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Common',
        type: 'common',
        fragment: Common,
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },
] as Config[]
