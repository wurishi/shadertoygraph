import { Config } from '../type'
import fragment from './glsl/4slGRH.glsl?raw'
export default [
    {
        // '4slGRH': 'Primes',
        name: '4slGRH',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
