import { Config } from '../type'
import fragment from './glsl/ldsGzS_89abba0a.glsl?raw'
export default [
    {
        // 'ldsGzS': 'I Want To Revert',
        name: 'ldsGzS',
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
