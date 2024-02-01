import { Config } from '../type'
import fragment from './glsl/XdXGWM_bb56b002.glsl?raw'
export default [
    {
        // 'XdXGWM': 'Simple Mosaic',
        name: 'XdXGWM',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
