import { Config } from '../type'
import fragment from './glsl/lslGRN_6d4a7422.glsl?raw'
export default [
    {
        // 'lslGRN': 'Grid Barrel Distortion',
        name: 'lslGRN',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
