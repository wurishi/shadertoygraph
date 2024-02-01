import { Config } from '../type'
import fragment from './glsl/MdlGDM_f6eb0d4e.glsl?raw'
export default [
    {
        // 'MdlGDM': 'waterly video - test',
        name: 'MdlGDM',
        type: 'image',
        fragment,
        channels: [
            { type: 'video' },
            {
                type: 'texture',
                src: 'Organic2',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
