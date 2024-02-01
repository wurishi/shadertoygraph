import { Config } from '../type'
import fragment from './glsl/XdX3zj_6d8e9f0a.glsl?raw'
export default [
    {
        // 'XdX3zj': 'emphasing textures',
        name: 'XdX3zj',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
