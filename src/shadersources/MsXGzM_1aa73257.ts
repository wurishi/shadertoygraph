import { Config } from '../type'
import fragment from './glsl/MsXGzM_1aa73257.glsl?raw'
export default [
    {
        // 'MsXGzM': 'Voronoi - rocks',
        name: 'MsXGzM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'linear',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'Empty' },
            { type: 'Empty' },
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
