import { Config } from '../type'
import fragment from './glsl/4ssGz8.glsl?raw'
export default [
    {
        // '4ssGz8': 'Reactive Slime',
        name: '4ssGz8',
        type: 'image',
        fragment,
        channels: [{ type: 'music' }],
    },
] as Config[]
