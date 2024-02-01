import { Config } from '../type'
import fragment from './glsl/Mds3R7_121a7fe.glsl?raw'
export default [
    {
        // 'Mds3R7': 'Lollypop (sound)',
        name: 'Mds3R7',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
