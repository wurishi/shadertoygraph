import { Config } from '../type'
import fragment from './glsl/wdfGW4.glsl?raw'
export default [
    {
        // 'wdfGW4': 'Descent 3D',
        name: 'wdfGW4',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
