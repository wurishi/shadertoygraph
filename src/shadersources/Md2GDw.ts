import { Config } from '../type'
import fragment from './glsl/Md2GDw.glsl?raw'
export default [
    {
        // 'Md2GDw': 'mpeg artifacts',
        name: 'Md2GDw',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'video',
            },
            {
                type: 'texture',
                src: 'RGBANoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
