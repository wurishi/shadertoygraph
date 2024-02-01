import { Config } from '../type'
import fragment from './glsl/wlSGWy.glsl?raw'
export default [
    {
        // 'wlSGWy': 'Raymarching in Raymarching',
        name: 'wlSGWy',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
