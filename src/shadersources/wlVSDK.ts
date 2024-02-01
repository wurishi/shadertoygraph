import { Config } from '../type'
import fragment from './glsl/wlVSDK.glsl?raw'
export default [
    {
        // 'wlVSDK': 'Danger Noodle',
        name: 'wlVSDK',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'cubemap',
                map: 'Forest',
                filter: 'linear',
                wrap: 'clamp',
                noFlip: true,
            },
            {
                type: 'cubemap',
                map: 'ForestBlur',
                filter: 'mipmap',
                wrap: 'clamp',
                noFlip: true,
            },
            { type: 'music' },
            { type: 'music' },
        ],
    },
] as Config[]
