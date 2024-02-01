import { Config } from '../type'
import fragment from './glsl/Msl3Dr_c1b5ab6d.glsl?raw'
export default [
    {
        // 'Msl3Dr': 'SoundMarch',
        name: 'Msl3Dr',
        type: 'image',
        fragment,
        channels: [
            { type: 'music' },
            {
                type: 'texture',
                src: 'Abstract2',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
