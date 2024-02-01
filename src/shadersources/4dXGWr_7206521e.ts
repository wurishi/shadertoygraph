import { Config } from '../type'
import fragment from './glsl/4dXGWr_7206521e.glsl?raw'
export default [
    {
        // '4dXGWr': 'Shiny taffy',
        name: '4dXGWr',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Organic1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
