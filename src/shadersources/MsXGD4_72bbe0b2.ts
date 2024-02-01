import { Config } from '../type'
import fragment from './glsl/MsXGD4_72bbe0b2.glsl?raw'
export default [
    {
        // 'MsXGD4': 'Dirty old CRT',
        name: 'MsXGD4',
        type: 'image',
        fragment,
        channels: [
            { type: 'video' },
            {
                type: 'texture',
                src: 'RGBANoiseSmall',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
