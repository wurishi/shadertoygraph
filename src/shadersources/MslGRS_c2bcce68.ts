import { Config } from '../type'
import fragment from './glsl/MslGRS_c2bcce68.glsl?raw'
export default [
    {
        // 'MslGRS': 'hq4x filter - Nyan Cat',
        name: 'MslGRS',
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
