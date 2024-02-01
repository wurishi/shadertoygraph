import { Config } from '../type'
import fragment from './glsl/ldsGDM_32619c14.glsl?raw'
export default [
    {
        // 'ldsGDM': 'GPU Precision',
        name: 'ldsGDM',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
