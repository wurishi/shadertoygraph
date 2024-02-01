import { Config } from '../type'
import fragment from './glsl/Msl3zM_36169d2d.glsl?raw'
export default [
    {
        // 'Msl3zM': 'Mars Fleet',
        name: 'Msl3zM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Stars',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'music' },
        ],
    },
] as Config[]
