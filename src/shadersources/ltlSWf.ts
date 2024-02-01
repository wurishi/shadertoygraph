import { Config } from '../type'
import fragment from './glsl/ltlSWf.glsl?raw'
export default [
    {
        // 'ltlSWf': 'Flux Core',
        name: 'ltlSWf',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
