import { Config } from '../type'
import fragment from './glsl/lss3Df.glsl?raw'
export default [
    {
        // 'lss3Df': 'Circle pattern',
        name: 'lss3Df',
        type: 'image',
        fragment,
        channels: [
            { type: 'Empty' },
            {
                type: 'texture',
                src: 'GrayNoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
