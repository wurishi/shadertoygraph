import { Config } from '../type'
import fragment from './glsl/lslGRM_f4432598.glsl?raw'
export default [
    {
        // 'lslGRM': 'Nyanrotozoom',
        name: 'lslGRM',
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
