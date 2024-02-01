import { Config } from '../type'
import fragment from './glsl/Msf3RH.glsl?raw'
export default [
    {
        // 'Msf3RH': 'Triangle Fan',
        name: 'Msf3RH',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Wood',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
