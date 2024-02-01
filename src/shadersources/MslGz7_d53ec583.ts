import { Config } from '../type'
import fragment from './glsl/MslGz7_d53ec583.glsl?raw'
export default [
    {
        // 'MslGz7': 'MandelOnTexture',
        name: 'MslGz7',
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
