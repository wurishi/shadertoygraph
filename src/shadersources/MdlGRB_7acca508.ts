import { Config } from '../type'
import fragment from './glsl/MdlGRB_7acca508.glsl?raw'
export default [
    {
        // 'MdlGRB': 'Webcam CRT',
        name: 'MdlGRB',
        type: 'image',
        fragment,
        channels: [
            { type: 'webcam', filter: 'linear', wrap: 'clamp' },
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
