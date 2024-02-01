import { Config } from '../type'
import fragment from './glsl/MsfGDH_3bfc5237.glsl?raw'
export default [
    {
        // 'MsfGDH': 'raster bars',
        name: 'MsfGDH',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Nyancat',
                filter: 'nearest',
                wrap: 'clamp',
                noFlip: true,
            },
        ],
    },
] as Config[]
