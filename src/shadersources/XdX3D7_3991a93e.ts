import { Config } from '../type'
import fragment from './glsl/XdX3D7_3991a93e.glsl?raw'
export default [
    {
        // 'XdX3D7': 'Focus shift',
        name: 'XdX3D7',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Organic1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
