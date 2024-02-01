import { Config } from '../type'
import fragment from './glsl/MdXGWM_e84d232a.glsl?raw'
export default [
    {
        // 'MdXGWM': 'Ripploroid',
        name: 'MdXGWM',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
