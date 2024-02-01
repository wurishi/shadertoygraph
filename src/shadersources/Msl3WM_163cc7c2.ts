import { Config } from '../type'
import fragment from './glsl/Msl3WM_163cc7c2.glsl?raw'
export default [
    {
        // 'Msl3WM': 'NyanCatHypnotic',
        name: 'Msl3WM',
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
