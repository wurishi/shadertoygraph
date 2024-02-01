import { Config } from '../type'
import fragment from './glsl/4sXGz2_f63002f3.glsl?raw'
export default [
    {
        // '4sXGz2': 'Transparency and scattering test',
        name: '4sXGz2',
        type: 'image',
        fragment,
        channels: [{ type: 'Empty' }, { type: 'Empty' }, { type: 'keyboard' }],
    },
] as Config[]
