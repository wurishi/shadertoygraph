import { Config } from '../type'
import fragment from './glsl/MdfGRB_1571456c.glsl?raw'
export default [
    {
        // 'MdfGRB': 'notsure',
        name: 'MdfGRB',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
