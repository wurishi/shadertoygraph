import { Config } from '../type'
import fragment from './glsl/WtfGDX.glsl?raw'
export default [
    {
        // 'WtfGDX': 'Triangle Grid Contouring',
        name: 'WtfGDX',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
