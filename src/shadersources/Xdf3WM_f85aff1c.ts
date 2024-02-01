import { Config } from '../type'
import fragment from './glsl/Xdf3WM_f85aff1c.glsl?raw'
export default [
    {
        // 'Xdf3WM': 'Mars',
        name: 'Xdf3WM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'music' },
        ],
    },
] as Config[]
