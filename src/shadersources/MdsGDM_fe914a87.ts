import { Config } from '../type'
import fragment from './glsl/MdsGDM_fe914a87.glsl?raw'
export default [
    {
        // 'MdsGDM': 'perlin video transition -test',
        name: 'MdsGDM',
        type: 'image',
        fragment,
        channels: [
            { type: 'video' },
            { type: 'video' },
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
