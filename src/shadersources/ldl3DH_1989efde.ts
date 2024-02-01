import { Config } from '../type'
import fragment from './glsl/ldl3DH_1989efde.glsl?raw'
export default [
    {
        // 'ldl3DH': 'Britney in space',
        name: 'ldl3DH',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
