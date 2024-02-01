import { Config } from '../type'
import fragment from './glsl/XsXGDM_879ba02.glsl?raw'
export default [
    {
        // 'XsXGDM': 'Chroma Key Composition',
        name: 'XsXGDM',
        type: 'image',
        fragment,
        channels: [
            { type: 'video' },
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
