import { Config } from '../type'
import fragment from './glsl/XslGR8.glsl?raw'
export default [
    {
        // 'XslGR8': 'real eye ball',
        name: 'XslGR8',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
