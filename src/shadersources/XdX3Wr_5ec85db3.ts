import { Config } from '../type'
import fragment from './glsl/XdX3Wr_5ec85db3.glsl?raw'
export default [
    {
        // 'XdX3Wr': 'warptest',
        name: 'XdX3Wr',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
