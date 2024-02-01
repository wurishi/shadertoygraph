import { Config } from '../type'
import fragment from './glsl/Xsl3W4_6cfe9d72.glsl?raw'
export default [
    {
        // 'Xsl3W4': 'Into the Darkness',
        name: 'Xsl3W4',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RustyMetal',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
