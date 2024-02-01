import { Config } from '../type'
import fragment from './glsl/XdsGz7_5c9f5af0.glsl?raw'
export default [
    {
        // 'XdsGz7': 'Kaleidoscope TvÃ¥',
        name: 'XdsGz7',
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
        ],
    },
] as Config[]
