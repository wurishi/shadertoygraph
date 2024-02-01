import { Config } from '../type'
import fragment from './glsl/4dXGWH_b40a8bac.glsl?raw'
export default [
    {
        // '4dXGWH': 'Nyancat',
        name: '4dXGWH',
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
            { type: 'music' },
        ],
    },
] as Config[]
