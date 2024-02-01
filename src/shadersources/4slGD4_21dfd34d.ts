import { Config } from '../type'
import fragment from './glsl/4slGD4_21dfd34d.glsl?raw'
export default [
    {
        // '4slGD4': 'Mountains',
        name: '4slGD4',
        type: 'image',
        fragment,
        channels: [
            { type: 'music' },
            {
                type: 'texture',
                src: 'Pebbles',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
