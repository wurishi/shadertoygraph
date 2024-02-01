import { Config } from '../type'
import fragment from './glsl/MdlGRr.glsl?raw'
export default [
    {
        // 'MdlGRr': 'Grid',
        name: 'MdlGRr',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
