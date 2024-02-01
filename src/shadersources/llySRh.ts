import { Config } from '../type'
import fragment from './glsl/llySRh.glsl?raw'
import A from './glsl/llySRh_A.glsl?raw'
import Cube from './glsl/llySRh_cube.glsl?raw'
export default [
    {
        // 'llySRh': 'iResolution, iMouse, iDate, etc',
        name: 'llySRh',
        type: 'image',
        fragment,
        channels: [
            { type: 'texture', src: 'Font1', filter: 'mipmap', wrap: 'clamp' },
            { type: 'video' },
            { type: 'music' },
            { type: 'keyboard' },
        ],
    },
    {
        type: 'cubemap',
        fragment: Cube,
    },
    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [],
    },
] as Config[]
