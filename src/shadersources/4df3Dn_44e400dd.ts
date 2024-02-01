import { Config } from '../type'
import fragment from './glsl/4df3Dn_44e400dd.glsl?raw'
export default [
    {
        // '4df3Dn': 'bicubic',
        name: '4df3Dn',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'London',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
