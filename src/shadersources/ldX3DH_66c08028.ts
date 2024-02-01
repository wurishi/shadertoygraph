import { Config } from '../type'
import fragment from './glsl/ldX3DH_66c08028.glsl?raw'
export default [
    {
        // 'ldX3DH': 'old school lens effect',
        name: 'ldX3DH',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Nyancat',
                filter: 'nearest',
                wrap: 'clamp',
                noFlip: true,
            },
            { type: 'music' },
        ],
    },
] as Config[]
