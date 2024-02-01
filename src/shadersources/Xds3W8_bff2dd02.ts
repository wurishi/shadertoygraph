import { Config } from '../type'
import fragment from './glsl/Xds3W8_bff2dd02.glsl?raw'
export default [
    {
        // 'Xds3W8': 'Simple Convolve',
        name: 'Xds3W8',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
