import { Config } from '../type'
import fragment from './glsl/4ss3Dn_f1e3ece2.glsl?raw'
export default [

    {
        // '4ss3Dn': 'Mandlebulb Evolution',
        name: '4ss3Dn',
        type: 'image',
        fragment,
        channels: [{ "type": "cubemap", "map": "Gallery", "filter": "linear", "wrap": "clamp", "noFlip": true }]
    },
] as Config[]