import { Config } from '../type'
import fragment from './glsl/Xsl3zX.glsl?raw'
export default [
    {
        // 'Xsl3zX': 'galaxy3',
        name: 'Xsl3zX',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'BlueNoise',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Stars',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'keyboard' },
        ],
    },
] as Config[]
