import { Config } from '../type'
import fragment from './glsl/Xs33Df.glsl?raw'
export default [
    {
        // 'Xs33Df': 'Desert Canyon',
        name: 'Xs33Df',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Pebbles',
                filter: 'mipmap',
                wrap: 'repeat',
            },
            {
                type: 'texture',
                src: 'Organic1',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
