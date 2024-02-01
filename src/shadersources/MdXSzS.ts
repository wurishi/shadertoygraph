import { Config } from '../type'
import fragment from './glsl/MdXSzS.glsl?raw'
export default [
    {
        // 'MdXSzS': 'Galaxy of Universes',
        name: 'MdXSzS',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
