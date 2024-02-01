import { Config } from '../type'
import fragment from './glsl/4dXGR4.glsl?raw'

export default [
    {
        name: '4dXGR4',
        type: 'image',
        fragment,
        channels: [{ type: 'texture', src: 'Organic2' }, { type: 'music' }],
    },
] as Config[]
