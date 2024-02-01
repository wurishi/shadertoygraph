import { Config } from '../type'
import fragment from './glsl/mdfXRN.glsl?raw'
import Common from './glsl/mdfXRN_common.glsl?raw'
import A from './glsl/mdfXRN_A.glsl?raw'
export default [
    {
        // webcam
        // 'mdfXRN': 'Unsharp Filter',
        name: 'mdfXRN',
        type: 'image',
        fragment,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            {
                type: 'webcam',
            },
        ],
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
        channels: [
            {
                type: 'webcam',
            },
        ],
    },
] as Config[]
