import { Config } from '../type'
import fragment from './glsl/4sGSRV.glsl?raw'
export default [
    {
        // '4sGSRV': 'Abstract Plane',
        name: '4sGSRV',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Organic3',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
