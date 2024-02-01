import { Config } from '../type'
import fragment from './glsl/tdjBR1.glsl?raw'
import Common from './glsl/tdjBR1_common.glsl?raw'
import Cube from './glsl/tdjBR1_cube.glsl?raw'

export default [
    {
        // 'tdjBR1': 'Volumetric lighting',
        name: 'tdjBR1',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'cubemap',
                // map: 'Basilica',
                filter: 'nearest',
                wrap: 'clamp',
            },
            {
                type: 'texture',
                src: 'BlueNoise',
                filter: 'linear',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'keyboard' },
        ],
    },
    {
        type: 'cubemap',
        fragment: Cube,
        channels: [
            { type: 'cubemap', filter: 'nearest', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'BlueNoise',
                filter: 'linear',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
    {
        name: 'Common',
        type: 'common',
        fragment: Common,
    },
] as Config[]
