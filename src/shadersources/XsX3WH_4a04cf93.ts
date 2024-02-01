import { Config } from '../type'
import fragment from './glsl/XsX3WH_4a04cf93.glsl?raw'
export default [
    {
        // 'XsX3WH': 'Peaks and fog',
        name: 'XsX3WH',
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
        ],
    },
] as Config[]
