import { Config } from '../type'
import fragment from './glsl/4slGR8.glsl?raw'
export default [
    {
        // '4slGR8': 'wowwow',
        name: '4slGR8',
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
