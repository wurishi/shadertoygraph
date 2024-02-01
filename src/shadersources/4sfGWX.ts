import { Config } from '../type'
import fragment from './glsl/4sfGWX.glsl?raw'
export default [
    {
        // '4sfGWX': 'Wolfenstein 3D',
        name: '4sfGWX',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
