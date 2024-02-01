import { Config } from '../type'
import fragment from './glsl/MdlXRS.glsl?raw'
export default [
    {
        // 'MdlXRS': 'Noise animation - Flow',
        name: 'MdlXRS',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'GrayNoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
