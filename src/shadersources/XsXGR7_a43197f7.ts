import { Config } from '../type'
import fragment from './glsl/XsXGR7_a43197f7.glsl?raw'
export default [
    {
        // 'XsXGR7': 'Shock Wave',
        name: 'XsXGR7',
        type: 'image',
        fragment,
        channels: [
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
