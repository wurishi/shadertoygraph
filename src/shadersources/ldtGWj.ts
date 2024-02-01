import { Config } from '../type'
import fragment from './glsl/ldtGWj.glsl?raw'
import A from './glsl/ldtGWj_A.glsl?raw'
export default [
    {
        // 'ldtGWj': 'Precalculated Voronoi Heightmap',
        name: 'ldtGWj',
        type: 'image',
        fragment,
        channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'repeat' }],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [
            { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
            {
                type: 'texture',
                src: 'RustyMetal',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
