import { Config } from '../type'
import fragment from './glsl/Xds3Rr.glsl?raw'
export default [
    {
        // 'Xds3Rr': 'Input - Sound',
        name: 'Xds3Rr',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
