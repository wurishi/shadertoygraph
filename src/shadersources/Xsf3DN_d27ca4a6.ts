import { Config } from '../type'
import fragment from './glsl/Xsf3DN_d27ca4a6.glsl?raw'
export default [
    {
        // 'Xsf3DN': 'Math2GL - Sphere mapping',
        name: 'Xsf3DN',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'London',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
