import { Config } from '../type'
import fragment from './glsl/Mdf3DH_bac4d929.glsl?raw'
export default [
    {
        // 'Mdf3DH': 'reflecting cube',
        name: 'Mdf3DH',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
