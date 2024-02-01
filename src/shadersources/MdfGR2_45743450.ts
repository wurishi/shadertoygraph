import { Config } from '../type'
import fragment from './glsl/MdfGR2_45743450.glsl?raw'
export default [
    {
        // 'MdfGR2': 'TRIPPY',
        name: 'MdfGR2',
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
            { type: 'Empty' },
            { type: 'Empty' },
            { type: 'video' },
        ],
    },
] as Config[]
