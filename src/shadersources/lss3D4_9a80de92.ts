import { Config } from '../type'
import fragment from './glsl/lss3D4_9a80de92.glsl?raw'
export default [
    {
        // 'lss3D4': 'Displacement in 137 chars',
        name: 'lss3D4',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'London',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            { type: 'video' },
        ],
    },
] as Config[]
