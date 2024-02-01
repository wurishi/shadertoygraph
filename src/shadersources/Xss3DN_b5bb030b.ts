import { Config } from '../type'
import fragment from './glsl/Xss3DN_b5bb030b.glsl?raw'
export default [
    {
        // 'Xss3DN': 'Bad chroma key + plasma',
        name: 'Xss3DN',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
