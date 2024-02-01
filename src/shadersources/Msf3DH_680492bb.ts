import { Config } from '../type'
import fragment from './glsl/Msf3DH_680492bb.glsl?raw'
export default [
    {
        // 'Msf3DH': 'perlin noise sphere',
        name: 'Msf3DH',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
