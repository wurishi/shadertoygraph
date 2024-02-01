import { Config } from '../type'
import fragment from './glsl/XdX3DN_104860a6.glsl?raw'
export default [
    {
        // 'XdX3DN': 'Black Hole',
        name: 'XdX3DN',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'London',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
