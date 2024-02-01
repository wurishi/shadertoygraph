import { Config } from '../type'
import fragment from './glsl/MsjSW3.glsl?raw'
export default [
    {
        // 'MsjSW3': 'Ether',
        name: 'MsjSW3',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
