import { Config } from '../type'
import fragment from './glsl/4ss3W7_82bb4420.glsl?raw'
export default [
    {
        // '4ss3W7': 'Procedural Normal Map',
        name: '4ss3W7',
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
