import { Config } from '../type'
import fragment from './glsl/Msl3RH.glsl?raw'
export default [
    {
        // 'Msl3RH': 'Derivatives - test',
        name: 'Msl3RH',
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
