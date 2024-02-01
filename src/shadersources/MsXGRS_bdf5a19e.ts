import { Config } from '../type'
import fragment from './glsl/MsXGRS_bdf5a19e.glsl?raw'
export default [
    {
        // 'MsXGRS': 'Rotational Fractal',
        name: 'MsXGRS',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
