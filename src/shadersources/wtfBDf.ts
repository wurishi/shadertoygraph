import { Config } from '../type'
import fragment from './glsl/wtfBDf.glsl?raw'
export default [
    {
        // 'wtfBDf': 'Warped Extruded Skewed Grid',
        name: 'wtfBDf',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Organic2',
                filter: 'linear',
                wrap: 'repeat',
            },
        ],
    },
] as Config[]
