import { Config } from '../type'
import fragment from './glsl/lss3D7_3898f28.glsl?raw'
export default [
    {
        // 'lss3D7': 'Power off',
        name: 'lss3D7',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
