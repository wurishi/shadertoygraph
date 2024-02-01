import { Config } from '../type'
import fragment from './glsl/Xdl3D2.glsl?raw'
export default [
    {
        // 'Xdl3D2': 'Interstellar',
        name: 'Xdl3D2',
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
