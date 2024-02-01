import { Config } from '../type'
import fragment from './glsl/4slGWH_1983afc8.glsl?raw'
export default [
    {
        // '4slGWH': 'Fractal Nyancat',
        name: '4slGWH',
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
