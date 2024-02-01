import { Config } from '../type'
import fragment from './glsl/lsVBWy.glsl?raw'
export default [
    {
        // 'lsVBWy': 'Matrix Code',
        name: 'lsVBWy',
        type: 'image',
        fragment,
        channels: [
            { type: 'texture', src: 'Font1', filter: 'mipmap', wrap: 'repeat' },
        ],
    },
] as Config[]
