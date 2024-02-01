import { Config } from '../type'
import fragment from './glsl/4sfGWN_9f5dea99.glsl?raw'
export default [
    {
        // '4sfGWN': 'Dropout',
        name: '4sfGWN',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
