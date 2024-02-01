import { Config } from '../type'
import fragment from './glsl/ldjBW1.glsl?raw'
export default [
    {
        // 'ldjBW1': '[SH17A] Matrix rain',
        name: 'ldjBW1',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
