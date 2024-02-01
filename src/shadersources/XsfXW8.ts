import { Config } from '../type'
import fragment from './glsl/XsfXW8.glsl?raw'
export default [
    {
        // 'XsfXW8': 'textured ellipsoids',
        name: 'XsfXW8',
        type: 'image',
        fragment,
        channels: [{ type: 'Empty' }, { type: 'Empty' }, { type: 'keyboard' }],
    },
] as Config[]
