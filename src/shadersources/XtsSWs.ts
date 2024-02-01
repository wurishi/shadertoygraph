import { Config } from '../type'
import fragment from './glsl/XtsSWs.glsl?raw'
export default [
    {
        // 'XtsSWs': 'Skyline',
        name: 'XtsSWs',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'cubemap',
                map: 'Gallery',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
        ],
    },
] as Config[]
