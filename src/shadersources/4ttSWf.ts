import { Config } from '../type'
import Image from './glsl/4ttSWf.glsl?raw'
import A from './glsl/4ttSWf_a.glsl?raw'

export default [
    {
        name: '4ttSWf',
        type: 'image',
        fragment: Image,
        channels: [{ type: 'buffer', id: 0 }],
    },
    {
        name: 'A',
        type: 'buffer',
        fragment: A,
        channels: [{ type: 'buffer', id: 0 }],
    },
] as Config[]
