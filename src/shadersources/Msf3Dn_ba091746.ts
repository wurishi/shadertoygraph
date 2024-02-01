import { Config } from '../type'
import fragment from './glsl/Msf3Dn_ba091746.glsl?raw'
export default [

    {
        // 'Msf3Dn': 'Sound Flower',
        name: 'Msf3Dn',
        type: 'image',
        fragment,
        channels: [{ "type": "music" }]
    },
] as Config[]