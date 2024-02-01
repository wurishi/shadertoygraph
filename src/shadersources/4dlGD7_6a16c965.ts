import { Config } from '../type'
import fragment from './glsl/4dlGD7_6a16c965.glsl?raw'
export default [
    {
        // '4dlGD7': 'Flower',
        name: '4dlGD7',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'cubemap',
                map: 'Forest',
                filter: 'mipmap',
                wrap: 'clamp',
                noFlip: true,
            },
        ],
    },
] as Config[]
