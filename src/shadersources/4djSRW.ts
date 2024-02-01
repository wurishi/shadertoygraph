import { Config } from '../type'

import fragment from './glsl/4djSRW.glsl?raw'
import common from './glsl/4djSRW_c.glsl?raw'
import sound from './glsl/4djSRW_s.glsl?raw'

export default [
    {
        name: '4djSRW',
        type: 'image',
        fragment,
    },
    {
        type: 'common',
        fragment: common,
    },
    {
        type: 'sound',
        fragment: sound,
    },
] as Config[]
