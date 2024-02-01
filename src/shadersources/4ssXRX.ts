import { Config } from '../type'
import fragment from './glsl/4ssXRX.glsl?raw'
export default [
    {
        // '4ssXRX': 'noise distributions',
        name: '4ssXRX',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
