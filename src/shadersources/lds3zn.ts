import { Config } from '../type'
import fragment from './glsl/lds3zn.glsl?raw'
export default [
    {
        // 'lds3zn': 'Ray tracing test',
        name: 'lds3zn',
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
            { type: 'music' },
        ],
    },
] as Config[]
