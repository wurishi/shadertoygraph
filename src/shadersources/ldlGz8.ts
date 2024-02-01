import { Config } from '../type'
import fragment from './glsl/ldlGz8.glsl?raw'
export default [
    {
        // 'ldlGz8': 'PhongShading',
        name: 'ldlGz8',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RockTiles',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
