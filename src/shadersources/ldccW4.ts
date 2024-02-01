import { Config } from '../type'
import fragment from './glsl/ldccW4.glsl?raw'
export default [
    {
        // 'ldccW4': 'Digital Rain',
        name: 'ldccW4',
        type: 'image',
        fragment,
        channels: [
            { type: 'texture', src: 'Font1', filter: 'mipmap', wrap: 'repeat' },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
