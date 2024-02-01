import { Config } from '../type'
import fragment from './glsl/3ddGzn.glsl?raw'
import A from './glsl/3ddGzn_A.glsl?raw'
import Common from './glsl/3ddGzn_common.glsl?raw'
export default [
    {
        // '3ddGzn': 'Then and Before - PC4k by Altair',
        name: '3ddGzn',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            { type: 'music' },
        ],
    },

    {
        name: 'Common',
        type: 'common',
        fragment: Common,
    },
] as Config[]
