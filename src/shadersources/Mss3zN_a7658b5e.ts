import { Config } from '../type'
import fragment from './glsl/Mss3zN_a7658b5e.glsl?raw'
export default [
    {
        // 'Mss3zN': 'Cheap bokeh effect',
        name: 'Mss3zN',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Stars',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
