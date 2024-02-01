import { Config } from '../type'
import fragment from './glsl/XdlGzH.glsl?raw'
export default [
    {
        // 'XdlGzH': 'Reprojection',
        name: 'XdlGzH',
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
