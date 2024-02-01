import { Config } from '../type'
import fragment from './glsl/MdXyzX.glsl?raw'
export default [
    {
        // 'MdXyzX': 'Very fast procedural ocean',
        name: 'MdXyzX',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
