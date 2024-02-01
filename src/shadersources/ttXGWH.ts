import { Config } from '../type'
import fragment from './glsl/ttXGWH.glsl?raw'
export default [
    {
        // 'ttXGWH': 'Abstract Terrain Objects',
        name: 'ttXGWH',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
