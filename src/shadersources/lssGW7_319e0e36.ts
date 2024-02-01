import { Config } from '../type'
import fragment from './glsl/lssGW7_319e0e36.glsl?raw'
import A from './glsl/lssGW7_319e0e36_A.glsl?raw'
export default [
    {
        // 'lssGW7': 'Brigthton Beach',
        name: 'lssGW7',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Organic2',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Organic1',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            { type: 'texture', src: 'Stars', filter: 'mipmap', wrap: 'repeat' },
        ],
    },

    {
        name: 'Buffer A',
        type: 'buffer',
        fragment: A,
        channels: [{ type: 'music' }],
    },
] as Config[]
