import { Config } from '../type'
import fragment from './glsl/3tXXRn.glsl?raw'
import Common from './glsl/3tXXRn_common.glsl?raw'
export default [
    {
        // '3tXXRn': 'Tentacle Object',
        name: '3tXXRn',
        type: 'image',
        fragment,
        channels: [
            { type: 'volume', volume: 'GreyNoise3D' },
            {
                type: 'texture',
                src: 'BlueNoise',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },

    {
        name: 'Common',
        type: 'common',
        fragment: Common,
    },
] as Config[]
