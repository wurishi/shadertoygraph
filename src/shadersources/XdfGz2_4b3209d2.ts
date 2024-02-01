import { Config } from '../type'
import fragment from './glsl/XdfGz2_4b3209d2.glsl?raw'
export default [
    {
        // 'XdfGz2': 'Distort',
        name: 'XdfGz2',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Abstract2',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
