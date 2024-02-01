import { Config } from '../type'
import fragment from './glsl/XsfGzM_59482eed.glsl?raw'
export default [
    {
        // 'XsfGzM': 'Nyan',
        name: 'XsfGzM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Organic1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
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
