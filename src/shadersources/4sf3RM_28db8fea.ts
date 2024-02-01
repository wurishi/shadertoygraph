import { Config } from '../type'
import fragment from './glsl/4sf3RM_28db8fea.glsl?raw'
export default [
    {
        // '4sf3RM': 'Island',
        name: '4sf3RM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Lichen',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
