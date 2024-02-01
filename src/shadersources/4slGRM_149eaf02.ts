import { Config } from '../type'
import fragment from './glsl/4slGRM_149eaf02.glsl?raw'
export default [
    {
        // '4slGRM': 'Water',
        name: '4slGRM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'RockTiles',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
