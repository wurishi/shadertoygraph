import { Config } from '../type'
import fragment from './glsl/4dl3D7_39ee09e9.glsl?raw'
export default [
    {
        // '4dl3D7': 'Colorize',
        name: '4dl3D7',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
