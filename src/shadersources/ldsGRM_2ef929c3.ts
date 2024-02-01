import { Config } from '../type'
import fragment from './glsl/ldsGRM_2ef929c3.glsl?raw'
export default [
    {
        // 'ldsGRM': 'Clock',
        name: 'ldsGRM',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }, { type: 'music' }],
    },
] as Config[]
